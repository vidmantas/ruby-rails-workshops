require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'

require 'dm-core'
require 'dm-migrations'
require 'dm-validations'

configure do
  enable :inline_templates, :sessions
end

# some support for testing
if ENV['RACK_ENV'] == 'test'
  DataMapper.setup(:default, "sqlite3::memory:")
else
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/main.db")
end

# otherwise html will look ugly, no-space
Slim::Engine.set_default_options :pretty => true

# === data models ===
class Word
  include DataMapper::Resource
  
  property :id,   Serial
  property :word, String, :required => true
  
  # TO DO: display validation errors to users
  validates_uniqueness_of :word
  
  has n, :notes
end

class Note
  include DataMapper::Resource
  
  property   :id,    Serial
  property   :note,  Text, :required => true
  
  belongs_to :word
end

DataMapper.finalize
DataMapper.auto_migrate! if test? or !File.exist?("main.db")


# === route definitions ===
get '/' do
  @words_count = Word.count
  logger.info "index: #{@words_count} words"
  slim :index
end

get '/about' do
  halt 403, "Nothing to see here. Go away, stranger!"
end

get '/list' do
  @words = Word.all(:order => :word.asc, :limit => 10)
  slim :index
end

post '/find' do
  @words = Word.all(:word.like => "%#{params[:term]}%")
  slim :index
end

get '/find/*' do
  @words = Word.all(:word.like => "%#{params[:splat][0]}%")
  slim :index
end

post '/words' do
  Word.create(params[:word])
  redirect "/"
end

get '/word/:word' do
  @word = Word.first(word: params[:word])
  # BUG: this doesn't quite work: session['last'] is reset on each request
  session['last'] = [] unless session[:last]
  session['last'] << @word.word
  slim :word
end

delete '/word/:id' do
  Word.get(params[:id]).destroy
end

post '/word/:word/notes' do
  word = Word.first(word: params[:word])
  word.notes.create(params[:note])
  redirect "/word/#{word.word}"
end

delete '/note/:id' do
  note = Note.get(params[:id])
  note.destroy
end

get '/play/:file' do
  # TO DO: streaming support:  stream do ...
  send_file "media/#{params[:file]}"
end

helpers do
  def last_viewed
    session['last'] || []
  end
  def active(it)
    'active' if request.path_info == it
  end
end

__END__

@@ layout
doctype html
html
  head
    meta charset="utf-8"
    title WordsApp
    link rel="stylesheet" media="screen" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css"
    link rel="stylesheet" media="screen" href="/styles.css"
    script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
    /[if lt IE 9]
      script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"
    javascript:
      $(function(){
        $('#search input:first').focus().keypress(function(ev){
          if (ev.which == 13)
            $('#search').submit();
        });
        $('a.del').click(function(){
          var el = $(this);
          $.post('/'+el.data('kind')+'/'+el.data('id'),
            {_method: 'delete'},
            function(){ el.closest('li').remove() }
          );
        });
      });
  body
    div.topbar
      div.fill
        div.container
          a.brand LOL
          == slim :topmenu
    div.container
      div.content
        div.page-header
          h1 
            | List <small>of various shit:</small>
            form action="/find" method="POST" id="search" style="display:inline"
              input type="text" name="term"
            
        div.row
          div.span10
            == yield
          div.span4
            == slim :sidebar
      footer
        p &copy; Remi 2012



@@ topmenu
ul.nav
  li[class=active('/')]
    a href="/" Main
  li[class=active('/list')]
    a href="/list" List
  li[class=active('/about')]
    a href="/about" About


@@ sidebar
h3 Last viewed
ul
- last_viewed.each do |word|
  li
    a href="/word/#{word}" == word



@@ index
p Items: #{@words_count || @words.size}

form.new action="/words" method="POST"
  input type="text" name="word[word]"
  input type="submit" value="+"

- if @words
  ul.words
    - @words.each do |word|
      li
        a href="/word/#{word.word}" == word.word
        a.del href="#" data-kind="word" data-id="#{word.id}" (x)



@@ word
h2 == @word.word

ul.notes
  - @word.notes.each do |note|
    li
      - if note.note =~ /\.mp3$/
        audio controls="controls"
          source src="/play/#{note.note}"
      - else
        span == note.note
      a.del href="#" data-kind="note" data-id="#{note.id}" (x)

form.new action="/word/#{@word.word}/notes" method="POST"
  input type="text" name="note[note]"
  input type="submit" value="+"
