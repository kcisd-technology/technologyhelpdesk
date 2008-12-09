if (typeof THD == 'undefined') {
  THD = {};
}

Object.extend( THD, {
  
  busyImage : function(){
    var img = new Image();
    img.src = THD.RootPath+"/images/busy.gif";
    return img;
  }(),
  
  Comment : {
    loadCommentControls : function() {
      var comments = document.getElementsByClassName('comment');
      $A(comments).each( function(comment){
        var controls = comment.getElementsByClassName('controls')[0];
        controls.insert({top: ' | '});

        var toggleLink = new Element('a', { href:"#", 'class':'showToggle'});
        toggleLink.insert("Hide Comment");
        toggleLink.observe('click', THD.Comment.toggleComment)
        controls.insert({top: toggleLink});

        var editLink = comment.getElementsByClassName('edit-link')[0];
        editLink.observe('click', THD.Comment.createEditForm);
      });
    },
    
    toggleComment : function(e) {
      var that = this;
      that.stopObserving('click');
      that.observe('click', function(e){e.stop();})
      var commentBody = that.up(".comment").down(".body");
      var reattachEvent = function(){
        that.stopObserving('click');
        that.observe('click', THD.Comment.toggleComment);
      }
      if(commentBody.visible()){
          Effect.SlideUp(commentBody, {afterFinish : reattachEvent });
          that.update("Show Comment");
      }else{
          Effect.SlideDown(commentBody, {afterFinish : reattachEvent });
          that.update("Hide Comment");
      }
      e.stop();
    },
    
    createEditForm : function(e){
      var comment = this.up('.comment');
      var commentBody = comment.down('.body').down('.content');
      commentBody.oldHTML = commentBody.innerHTML;
      commentBody.update(THD.busyImageTag);
      Effect.ScrollTo(comment);
      new Ajax.Request( this.href, {evalScripts : true, method : 'get' });
      this.update("Cancel");
      this.stopObserving('click');
      this.observe('click', THD.Comment.cancelCommentEdit);
      e.stop();
    },
    
    cancelCommentEdit : function(e) {
      var comment = this.up('.comment');
      var commentBody = comment.down('.body').down('.content');
      commentBody.update(commentBody.oldHTML);
      THD.Comment.resetEditButton(
        commentBody.up('.comment').down('.edit-link')
      );
      Effect.ScrollTo(commentBody.up('.comment'));
      e.stop();
    },
    
    submitCommentChanges : function(e) {
      var form = e.target;
      var params = form.serialize(true);
      var comment = form.up('.comment');
      var commentBody = comment.down('.body').down('.content');
      new Ajax.Updater( commentBody, form.action, {
        method : 'put',
        // form.serialize() did not work in IE
        //parameters : form.serialize(true),
        // had to use:
        parameters : params,
        // wierd
        onComplete : function(response) {
            Effect.ScrollTo(comment);
        },
        onSuccess : function(response) {
          commentBody.update(response.responseText);
        }
      });
      THD.Comment.resetEditButton(
        commentBody.up('.comment').down('.edit-link')
      );
      e.stop();
    },
    
    resetEditButton : function(button) {
      button.update("Edit").stopObserving('click').observe(
        'click', THD.Comment.createEditForm
      );
    }
  }
});

THD.busyImageTag = function(){
  return new Element('div', {align:'center'}).update(
    new Element('img', {src : THD.busyImage.src})
  );
}();

Event.observe(document, 'dom:loaded', THD.Comment.loadCommentControls)