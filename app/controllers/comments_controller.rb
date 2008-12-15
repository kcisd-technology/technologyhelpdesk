class CommentsController < ApplicationController
  
  before_filter :login_required
  access_control :DEFAULT => 'admin'
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html {
        redirect_to @comment.top_commentable
      }
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @parent = parent_object
    @comment = @parent.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @parent = parent_object
    @comment = @parent.comments.new(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { 
          if request.xhr?
            render :text => liquidize_comment(@comment)
          else
            redirect_to(@comment)
          end            
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :action => "edit", :status => :unprocessable_entity }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @parent = params[:commit] && @comment.top_commentable
    @comment.destroy
    @parent && flash[:notice] = "Comment was deleted"

    respond_to do |format|
      format.html { redirect_to(@parent || :back) }
      format.xml  { head :ok }
    end
  end
  
  def delete
    @comment = Comment.find(params[:id])
  end
  
  protected
  def parent_object
    case
    when params[:comment_id] then Comment.find(params[:comment_id])
    when params[:howto_id] then Howto.find(params[:howto_id])
    when params[:device_id] then Device.find(params[:device_id])
    when params[:software_id] then Software.find(params[:software_id])
    else raise ActiveRecord::RecordNotFound
    end
  end
  
end
