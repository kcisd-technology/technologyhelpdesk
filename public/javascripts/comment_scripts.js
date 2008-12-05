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
  var commentBody = this.up('.comment').down('.body').down('.content');
  commentBody.oldHTML = commentBody.innerHTML;
  commentBody.update(busyImageTag);
  new Ajax.Request( this.href, {evalScripts : true, method : 'get' });
  this.update("Cancel");
  this.stopObserving('click');
  this.observe('click', cancelCommentEdit);
  e.stop();
}

var cancelCommentEdit = function(e) {
  var commentBody = this.up('.comment').down('.body').down('.content');
  var commentID = commentBody.id.gsub("comment_body_", '');
  //commentBody.update(busyImageTag);
  //new Ajax.Updater(commentBody, "/comments/"+commentID+"/edit?cmd=cancel", {evalScripts : true, method : 'get' });
  commentBody.update(commentBody.oldHTML);
  var editLink = commentBody.up('.comment').down('.edit-link');
  editLink.update("Edit");
  editLink.stopObserving('click');
  editLink.observe('click', createEditForm)
  Effect.ScrollTo(commentBody.up('.comment'));
  e.stop();
}

var submitCommentChanges = function(e) {
  var commentBody = this.up('.comment').down('.body').down('.content');
  commentBody.update(busyImageTag);
  new Ajax.Updater( commentBody, this.action, {
    parameters : this.serialize(),
    onComplete : function() {
        Effect.ScrollTo(commentBody.up('.comment'));
    }
  });
  e.stop();
  var editLink = commentBody.up('.comment').down('.edit-link');
  editLink.update("Edit");
  editLink.stopObserving('click');
  editLink.observe('click', createEditForm)
}

busyImage = new Image();
busyImage.src = "/images/busy.gif";
busyImageTag = new Element('div', {align:'center'}).update(
  new Element('img', {src : busyImage.src})
);

Event.observe(document, 'dom:loaded', loadCommentControls)