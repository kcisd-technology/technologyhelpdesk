var loadCommentControls = function() {
  var comments = document.getElementsByClassName('comment');
  $A(comments).each( function(comment){
    var controls = comment.getElementsByClassName('controls')[0];
    controls.insert({top: ' | '});
    
    var toggleLink = new Element('a', { href:"#", 'class':'showToggle'});
    toggleLink.insert("Hide Comment");
    toggleLink.observe('click', toggleComment)
    controls.insert({top: toggleLink});    
  });
}
var toggleComment = function(e) {
  var commentBody = this.up(".comment").down(".body");
  if(commentBody.visible()){
      Effect.BlindUp(commentBody);
      this.update("Show Comment");
  }else{
      Effect.BlindDown(commentBody);
      this.update("Hide Comment");
  }
  e.stop();
}
Event.observe(window, 'load', loadCommentControls)