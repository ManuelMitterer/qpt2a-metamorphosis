  # Autoren:  Manuel Mitterer, Matthias Prieth
  # Lizenz:   AGPL 3

class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :user_is_creator, only: [:edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def user_is_creator
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
      redirect_to root_url
    end
  end

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
#  def create
#    @comment = Comment.new(params[:comment])
#
#    respond_to do |format|
#      if @comment.save
#        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
#        format.json { render json: @comment, status: :created, location: @comment }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @comment.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  def create
    picture_id = params[:comment][:picture_id]
    @picture = Picture.find(picture_id)
    @comment = @picture.comments.build(params[:comment])
    @comment.picture = @picture
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to root_url }
      else
        format.html { render :new }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

end
