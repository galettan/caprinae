json.array!(@projects) do |project|
  json.extract! project, :id, :name, :number, :owner_id, :worker_id
  json.url project_url(project, format: :json)
end
