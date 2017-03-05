module Libraries
  module LinksHelper

    def edit_cloud_library_link(cloud, library)
      edit_resource_link library,
      url: edit_cloud_library_path(id: library.id, cloud_id: cloud.id),
      form_class: 'display_inline',
      text: 'Edit', icon: 'fa-edit', title: "Edit #{library.name}"
    end

    def delete_cloud_library_link(cloud, library)
      destroy_resource_link library,
      url: cloud_library_path(id: library.id, cloud_id: cloud.id),
      form_class: 'display_inline pull_right_wide_media',
      text: 'Delete', icon: 'fa-trash', title: "Delete #{library.name}",
      confirm: {text: "Are you sure that you want to delete #{library.name}?",
                title: {text: 'Confirm delete'} }
    end

    def new_cloud_library_link(cloud)
      new_resource_link :cloud_library, text: 'New',
        params: { cloud_id: cloud.id }
    end

  end
end
