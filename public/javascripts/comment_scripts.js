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
        
        var deleteLink = comment.down('.delete-link');
        deleteLink.observe('click', THD.Comment.deleteComment);
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
      THD.Comment.disableEditLink( this );
      e.stop();
    },
    
    cancelCommentEdit : function(e) {
      var comment = this.up('.comment');
      var commentBody = comment.down('.body').down('.content');
      commentBody.update(commentBody.oldHTML);
      THD.Comment.resetEditButton(
        comment.down('.edit-link')
      );
      Effect.ScrollTo(commentBody.up('.comment'));
      e.stop();
    },
    
    submitCommentChanges : function(e) {
      var form = e.target;
      var params = form.serialize(true);
      var comment = form.up('.comment');
      var commentBody = comment.down('.body').down('.content');
      new Ajax.Request( form.action, {
        method : 'put',
        evalScripts : true,
        parameters : params,
        onComplete : function(response) {
            Effect.ScrollTo(comment);
        },
        onSuccess : function(response) {
          commentBody.update(response.responseText);
        },
        onFailure : function() {
        }
      });
      THD.Comment.resetEditButton(
        comment.down('.edit-link')
      );
      e.stop();
    },
    
    deleteComment : function(e) {
      if(confirm("Are you sure?")){
        var comment = this.up('.comment');
        var commentURL = this.href.gsub(/\/delete/, '');
        var token = $F($$('input[name="authenticity_token"]')[0])
        
        var busy = new Element('div',{style:'height:25px;background-color:#ff0'});
        busy.update(
          (new Element('div', {style:'float:left;'})).update("Deleteing")
        ).insert(THD.busyImageTag);
        comment.insert({top: busy});
        
        new Ajax.Request( commentURL, {
          method : 'delete',
          parameters : {
            'authenticity_token' : token
          },
          onSuccess : function() {
            Effect.Puff(comment, {
              afterFinish : function() { comment.remove(); }
            });
          },
          onFailure : function() {
            alert( 'it failed');
            busy.remove();
          }
        })
      }
      e.stop();
    },
    
    disableEditLink : function( link ) {
      link.update("Cancel").stopObserving('click').observe(
        'click', THD.Comment.cancelCommentEdit
      );
    },
    
    resetEditButton : function( link ) {
      link.update("Edit").stopObserving('click').observe(
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