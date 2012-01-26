$(function(){
  $('#search input:first').focus();
  
  $('#search input').keypress(function(ev){
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
