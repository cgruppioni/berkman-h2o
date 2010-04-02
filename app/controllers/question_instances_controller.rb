class QuestionInstancesController < BaseController
  cache_sweeper :question_instance_sweeper
  before_filter :prep_resources
  after_filter :update_question_instance_time

  # GET /question_instances
  # GET /question_instances.xml
  def index
    add_stylesheets "tablesorter-blue-theme/style"
    add_javascripts "jquery.tablesorter.min"

    @question_instances = QuestionInstance.all

    respond_to do |format|
      format.html { render :layout => (! request.xhr?) }
      format.xml  { render :xml => @question_instances }
    end
  end

  def updated
    @question_instance = QuestionInstance.find(params[:id])
    render :text => @question_instance.updated_at.to_s
  end

  # GET /question_instances/1
  # GET /question_instances/1.xml
  def show
    @question_instance = QuestionInstance.find(params[:id])

    respond_to do |format|
      format.html {render :layout => (request.xhr?) ? false : true} 
      format.xml  { render :xml => @question_instance }
    end
  end

  # GET /question_instances/new
  # GET /question_instances/new.xml
  def new
    add_stylesheets ["formtastic","forms"]
    @question_instance = QuestionInstance.new

    respond_to do |format|
      format.html { render :partial => 'shared/forms/question_instance', :layout => false} 
      format.xml  { render :xml => @question_instance }
    end
  end

  # GET /question_instances/1/edit
  def edit
    add_stylesheets ["formtastic","forms"]
    @question_instance = QuestionInstance.find(params[:id])
  end

  # POST /question_instances
  # POST /question_instances.xml
  def create
    add_stylesheets ["formtastic","forms"]
    @question_instance = QuestionInstance.new(params[:question_instance])

    respond_to do |format|
      if @question_instance.save
        @UPDATE_QUESTION_INSTANCE_TIME = @question_instance
        flash[:notice] = 'QuestionInstance was successfully created.'
        format.html { render :text => @question_instance.id, :layout => false }
        format.xml  { render :xml => @question_instance, :status => :created, :location => @question_instance }
      else
        format.html { render :text => "We couldn't add that question instance. Sorry!<br/>#{@question_instance.errors.full_messages.join('<br/')}", :status => :unprocessable_entity }
        format.xml  { render :xml => @question_instance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /question_instances/1
  # PUT /question_instances/1.xml
  def update
    add_stylesheets ["formtastic","forms"]
    @question_instance = QuestionInstance.find(params[:id])

    respond_to do |format|
      if @question_instance.update_attributes(params[:question_instance])
        @UPDATE_QUESTION_INSTANCE_TIME = @question_instance
        flash[:notice] = 'Question Instance was successfully updated.'
        format.html { redirect_to(@question_instance) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question_instance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /question_instances/1
  # DELETE /question_instances/1.xml
  def destroy
    @question_instance = QuestionInstance.find(params[:id])
    @question_instance.destroy

    respond_to do |format|
      format.html { redirect_to(question_instances_url) }
      format.xml  { head :ok }
    end
  end

  private

  def prep_resources
    add_stylesheets 'question_tool'
    add_javascripts 'question_tool'
  end

end
