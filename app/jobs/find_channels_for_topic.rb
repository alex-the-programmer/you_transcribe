class FindChannelsForTopic
    include Sidekiq::Worker

    def perform(topic_id)
        topic = Topic.find(topic_id)

        driver = Selenium::WebDriver.for :firefox
        driver.navigate.to "https://www.youtube.com/"
        sleep(5)
        search_bar = driver.find_element(:css, 'input#search')
        search_bar.send_keys(topic.name)
        search_bar.send_keys(:return)
        sleep(5)

        scroll = 0
        channels = nil
        until channels&.count&.>=(200) do
            sleep(5) 
            driver.execute_script("window.scrollTo(#{scroll}, #{scroll + 3000})")
            channels = driver.find_elements(:id, 'channel-info')
            scroll = scroll + 3000
        end 


        channels.each do |channel|
            channel_link = channel.find_element(:css, '#channel-name a')
            topic.channels.create_with(
                name: channel_link.text,
                slug: channel_link.text.parameterize,
                channel_type: topic.topic_type, 
            ).find_or_create_by!(url: channel_link[:href])
        end

        topic.processed!

        driver.quit
    end
end
