xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Most recently created projects"
    xml.description "The 10 newest projects from the CDDN"
    xml.link events_path

    @project_rss.each do |project|
      xml.item do
        xml.title project.name
        xml.description project.description
        xml.pubDate project.created_at.to_s(:rfc822)
        xml.link project_path(project)
        xml.guid project_path(project)
      end
    end
  end
end