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
  var that = this;
  that.stopObserving('click');
  that.observe('click', function(e){e.stop();})
  var commentBody = that.up(".comment").down(".body");
  var reattachEvent = function(){
    that.stopObserving('click');
    that.observe('click', toggleComment);
  }
  if(commentBody.visible()){
      Effect.BlindUp(commentBody, {afterFinish : reattachEvent });
      that.update("Show Comment");
  }else{
      Effect.BlindDown(commentBody, {afterFinish : reattachEvent });
      that.update("Hide Comment");
  }
  e.stop();
}
Event.observe(document, 'dom:loaded', loadCommentControls)