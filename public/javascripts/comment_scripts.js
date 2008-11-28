var loadCommentControls = function() {
  var comments = document.getElementsByClassName('comment');
  $A(comments).each( function(comment){
    var controls = comment.getElementsByClassName('controls')[0];
    controls.insert({top: ' | '});
    
    var toggleLink = new Element('a', { href:"#"});
    toggleLink.insert("Hide Comment");
    toggleLink.observe('click', toggleComment)
    controls.insert({top: toggleLink});    
  });
}
var toggleComment = function(e) {
  var commentBody = this.up(".comment").down(".body");
  if(commentBody.visible()){
      commentBody.hide();
      this.update("Show Comment");
  }else{
      commentBody.show();
      this.update("Hide Comment");
  }
  e.stop();
}
Event.observe(window, 'dom:loaded', loadCommentControls)