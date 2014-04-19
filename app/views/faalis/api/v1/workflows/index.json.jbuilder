json.array! @workflows do |workflow|
  json.extract! workflow, :id, :title, :icon, :image
  json.have_icon workflow.icon?
  json.have_image workflow.image?
end
