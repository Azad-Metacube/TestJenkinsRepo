global class MySiteUrlRewriter implements Site.UrlRewriter {

    String DIRECTORY = '/news';
    String VISUALFORCE_PAGE = '/page?pageid=';
    
    global PageReference mapRequestUrl(PageReference myFriendlyUrl){
        String url = myFriendlyUrl.getUrl();
        if(url.startsWith(DIRECTORY)){
            return new pageReference('/Hello');
        }
        return null;    
    }

    global List<PageReference> generateUrlFor(List<PageReference> mySalesforceUrls){
        List<PageReference> myFriendlyUrls = new List<PageReference>();
        for(PageReference mySalesforceUrl : mySalesforceUrls){
            String url = mySalesforceUrl.getUrl();
            if(url.startsWith(VISUALFORCE_PAGE)){
             }  

             else {
                 myFriendlyUrls.add(mySalesforceUrl);

             }
    
          }
        return myFriendlyUrls;
    }
}