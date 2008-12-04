var loadCommentControls = function() {
  var comments = document.getElementsByClassName('comment');
  $A(comments).each( function(comment){
    var controls = comment.getElementsByClassName('controls')[0];
    controls.insert({top: ' | '});
    
    var toggleLink = new Element('a', { href:"#", 'class':'showToggle'});
    toggleLink.insert("Hide Comment");
    toggleLink.observe('click', toggleComment)
    controls.insert({top: toggleLink});
    
    var editLink = comment.getElementsByClassName('edit-link')[0];
    editLink.observe('click', createEditForm);
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
      Effect.SlideUp(commentBody, {afterFinish : reattachEvent });
      that.update("Show Comment");
  }else{
      Effect.SlideDown(commentBody, {afterFinish : reattachEvent });
      that.update("Hide Comment");
  }
  e.stop();
}

var createEditForm = function(e){
  new Ajax.Request( e.target.href, {evalScripts : true, method : 'get' });
  e.stop();
}

Event.observe(document, 'dom:loaded', loadCommentControls)