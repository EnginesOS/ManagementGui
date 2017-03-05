module Clouds
  module DetailsHelper

    def cloud_menu_cloud_details(cloud)
      content_tag(:div, class: 'container_menu_header clearfix') do
        content_tag(:div, class: 'container_menu_header_icon') do
          unless cloud.icon.blank? || cloud.icon.dirty?
            image_tag cloud.icon.url(:small), alt: ''
          end
        end +
        content_tag(:div, class: 'container_menu_header_names') do
          content_tag(:div, class: 'container_menu_header_label') do
            cloud.label
          end +
          content_tag(:div, class: 'container_menu_header_label_subtext') do
          end
        end +
        content_tag(:div, class: 'container_menu_header_detail pull_right_wide_media') do
          content_tag(:div, pluralize(cloud.engines_systems.count, "system")) +
          content_tag(:div, pluralize(cloud.engines_systems.map(&:apps).map(&:count).sum, "app"))
        end
      end +
      content_tag(:div, class: 'clearfix') do
        edit_resource_link :cloud_properties, params: {cloud_id: cloud.id}, text: 'Edit', icon: 'fa-edit', title: "Edit #{cloud.label} display properties", class: 'pull_right_wide_media'
      end
    end

  end
end
