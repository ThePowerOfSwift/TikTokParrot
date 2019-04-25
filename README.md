# TikTokParrot

When designing my version of TikTok I began by splitting the application into 2 parts:
1. Consumption
2. Creation

I prioritized building the Consumption half because:
 - This is the first part of the app that users will interact with and is essential to its existence.
 - The majority of the features in the Creation half of the app did not seem essential when demonstrating the mechanics of the app
 - The majority of social media users consume more content than they create so Consumption features will draw users in before creation features
 - I was instructed to use existing content from livestreamfails.com so a lack of content was not a concern

I split the Consumption features into the following Scenes:
<br/><br/>
### BASE 
This scene is the foundation of the app. Its function is to display the 5 primary Menu options - HomeFeed, Search, Create, Notifications, Profile - at the bottom of the screen and subsequently display the corresponding Scene.

I chose to load child view controllers into the Base scene when needed. This requires less memory than loading all 4 View Controllers at the same time and then only showing the View Controller corresponding to the Menu selection. 

To ensure efficient loading of the relevant video streams into the HomeFeed table view, I decided to create and store the video streams (VideoPlayerView) in the Base scene. 

I embedded the BaseViewController in a Navigation Controller as this was the quickest way to mimic TikTok’s ability to segue from the HomeFeed to a User’s Profile

I decided not to include the “Following” and “For You” feature at the top of the screen as they both use the same core mechanics and this would be redundant within the 8 hour constraint.

**_Issues:_**
1. I created the Menu using a Collection View but struggled to cleanly integrate the Create Button. I decided to overlay a Button on the Menu Collection View as this creates the desired Menu mechanic within the time constraints but is likely harder to maintain/update.
<br/><br/>
### HOMEFEED
This scene displays video streams to the User and provides it’s own menu options - Profile (belonging to displayed video’s owner), Like, Comments, Share. 
I prioritized the display of video streams as this is the foundational feature of the app. My next highest priority was displaying the User’s Profile as this allows access to additional video content. It is also harder to imagine than the display of Comments or Sharing Options  and so gives a better impression of how the final product will look and feel.

When the HomeFeed Menu option is selected, the Base scene passes the VideoPlayerViews to the HomeFeed scene wherein they are embedded in the HomeFeedViewController’s table view.

The HomeFeed Scene is recycled for use in the Profile scene for the display of a User’s Videos

**_Issues:_**
1. When the HomeFeedViewController first loads, the Table View shifts down to accommodate the Status Bar. When the user interacts with the view, the table view shifts back up. I spent some time trying to fix this issue but abandoned the effort because, although it isn’t pretty, it does not interfere with the flow of the app or the display of the video.
2. When the When the HomeFeedViewController first loads, the VideoPlayerView is not centred in the first Cell of the Table View. I am quite certain this also has to do with properly managing the Status Bar. It is also due to the way I designed the VideoTableViewCell that displays the streams. I opted to not fix it as the stream will be displayed either way, even if it’s not pretty.
3. In TikTok, when a User navigates away from the HomeFeed and later returns, the video that was last viewed should still be displayed. I decided to use the scrollToRow: function after loading the Table View due to time restrictions. This provides the desired mechanic but the scrolling is visible which is ugly! I ran out of time before implementing this feature fully so it only exists while viewing videos in as User’s Profile.
<br/><br/>
### PROFILE
This scene displays a User’s Details, their Videos and their liked Videos. 

I prioritized the display of User Videos as I judged video content to be the core element of this app. Also, without scraping the Live Stream Fails website for Its Users, there are no Users for this app, so there would be no content to display had I created the UI necessary to display it.

Similar to the HomeFeed, I decided not implement a feature that would switch between a User’s videos and their “liked” videos as they would both function identically given the scope.

**_Issues:_**
1. When the HomeFeed scene is loaded to display User Videos, a few seconds will elapse before the video begins to play. I opted to not look into this because the video will eventually play and that is the core functionality I was trying to create.
2. The User can see the Table View scroll to the Cell containing the stream corresponding to the thumbnail they pressed. As mentioned in the HomeFeed description, this is ugly but functional!
<br/><br/>
### SEARCH
I did not prioritize this scene because it is easy to imagine what a search function would entail and it would be difficult/ lengthy to implement.
<br/><br/>
### NOTIFICATIONS
I did not prioritize this scene because with no back end there would be no notifications worth displaying within an 8 hour development period.
<br/><br/>
#### Other Notes:

1. I employed the VIP development pattern because it’s my preferred pattern. If I were to continue developing this app, I believe that VIP would create the best environment for implementing Unit Tests and streamlining maintenance. However, I acknowledge that TikTok is likely built using a more common pattern like MVC or MVVM and building my app with one of these patterns might have looked better from that perspective.

2. I decided to hardcode all streaming URLs primarily because of the time constraints. The core mechanics of the app can be displayed without scraping the Live Stream Fails HTML content for updated content and user information. I also don’t know automate HTML scraping nor would it be necessary when working on the real TikTok application as there is certainly a backend server that I could access through REST or some other service.

3. I chose iOS 9.0 as the minimum version supported because a very large majority will have a higher version. Choosing this version required no extra code to provide all of the desired features.

