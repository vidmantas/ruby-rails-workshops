json.array!(@girls) do |girl|
  json.extract! girl, :name, :phone, :stars
  json.url girl_url(girl, format: :json)
end
