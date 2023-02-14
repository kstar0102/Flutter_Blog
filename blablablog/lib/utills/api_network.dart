class ApiNetwork {
  static const String baseUrl = 'https://api.taillz.com/api/v1/';
  static const String userLogin = '${baseUrl}clients/login';
  static const String getUserInfo = '${baseUrl}clients/info';
  static const String getStories = '${baseUrl}stories';
  static const String viewStories = '${baseUrl}stories';
  static const String getTopics = '${baseUrl}lists/topics';
  static const String getColors = '${baseUrl}lists/colors';
  static const String getCountries = '${baseUrl}lists/countries';
  static const String getLanguages = '${baseUrl}lists/languages';
  static const String registration = '${baseUrl}clients/register';
  static const String passwordRecovery = '${baseUrl}clients/recovery';
  static const String getStoriesByTopic = '${baseUrl}stories?catalog=';
  static const getMyPublishedStories = '${baseUrl}stories?Me=1&status=1';
  static const getMyDraftStories =
      '${baseUrl}stories?page=0&limit=10&Me=1&status=2';
  static const getMyPendingStories =
      '${baseUrl}stories?page=0&limit=10&Me=1&status=0';
  static const getMyDeclinedStories =
      '${baseUrl}stories?page=0&limit=10&Me=1&status=3';
  static const String inbox = '${baseUrl}inbox';

  static const String deleteComment = '${baseUrl}comments/';
  static const String deleteStory = '${baseUrl}stories/';
  static const String notifications = '${baseUrl}notifications';
  static const toggleComments = '${baseUrl}stories/';
  static const String followUser = '${baseUrl}clients/'; // Post
  static const String unfollowUser = '${baseUrl}clients/'; // Delete
  static const String reportUser = '${baseUrl}clients/report';
  static const String blockUser = '${baseUrl}clients/block';
  static const String deleteConversation = '${baseUrl}inbox?userId=';
  static const String sendMessage =
      'https://api.taillz.com/chatHub?id=u14M3ZAqbCo9uRG4Pu6zYw';
  static const String getNotification =
      '${baseUrl}User/Notifications?limit=20&page=';

  static const getFollowingUsers = '${baseUrl}clients/blablog?mode=1';
  static const getFollowers = '${baseUrl}clients/blablog?mode=02';
  static const getBlockedUsers = '${baseUrl}clients/blocked';
  static const getHiddenUsers = '${baseUrl}clients/hidden';
  static const getComments = '${baseUrl}comments/';
  static const createStory = '${baseUrl}stories';
  static const getRepliesOnComment = '${baseUrl}RepliedComments';
  static const likeComment = '${baseUrl}Comments/AddLikes';
  static const unLikeComment = '${baseUrl}Comments/RemoveLikes';
}

class Header {
  authenticatedHeaders(String token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  unAuthenticatedHeaders() {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }
}
