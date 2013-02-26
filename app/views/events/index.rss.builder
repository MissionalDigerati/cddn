xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Most recently created events"
    xml.description "The 10 newest events from the CDDN"
    xml.link events_path

    @event_rss.each do |event|
      xml.item do
        xml.title event.title
        xml.description event.details
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link event_path(event)
        xml.guid event_path(event)
      end
    end
  end
end