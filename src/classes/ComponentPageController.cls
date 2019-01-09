public class ComponentPageController {

    public PageReference run() {
        return new PageReference('/apex/component');
    }

    public String SoqlString { get; set; }
   
}