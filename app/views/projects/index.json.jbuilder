json.array!(@projects) do |project|
  json.extract! project, :id, :name, :number, :user_id_id, :user_assigned_id
  json.url project_url(project, format: :json)
end
