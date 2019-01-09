public class NewStudentContoller {
 public PageReference overideSave(){
 	return new PageReference('/apex/ClassNew?retURL=%2Fa01%2Fo&save_new=1&sfdc.override=1');
 }
}