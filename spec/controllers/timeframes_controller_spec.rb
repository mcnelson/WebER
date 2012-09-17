require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe TimeframesController do

  # This should return the minimal set of attributes required to create a valid
  # Timeframe. As you add validations to Timeframe, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TimeframesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all timeframes as @timeframes" do
      timeframe = Timeframe.create! valid_attributes
      get :index, {}, valid_session
      assigns(:timeframes).should eq([timeframe])
    end
  end

  describe "GET show" do
    it "assigns the requested timeframe as @timeframe" do
      timeframe = Timeframe.create! valid_attributes
      get :show, {:id => timeframe.to_param}, valid_session
      assigns(:timeframe).should eq(timeframe)
    end
  end

  describe "GET new" do
    it "assigns a new timeframe as @timeframe" do
      get :new, {}, valid_session
      assigns(:timeframe).should be_a_new(Timeframe)
    end
  end

  describe "GET edit" do
    it "assigns the requested timeframe as @timeframe" do
      timeframe = Timeframe.create! valid_attributes
      get :edit, {:id => timeframe.to_param}, valid_session
      assigns(:timeframe).should eq(timeframe)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Timeframe" do
        expect {
          post :create, {:timeframe => valid_attributes}, valid_session
        }.to change(Timeframe, :count).by(1)
      end

      it "assigns a newly created timeframe as @timeframe" do
        post :create, {:timeframe => valid_attributes}, valid_session
        assigns(:timeframe).should be_a(Timeframe)
        assigns(:timeframe).should be_persisted
      end

      it "redirects to the created timeframe" do
        post :create, {:timeframe => valid_attributes}, valid_session
        response.should redirect_to(Timeframe.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved timeframe as @timeframe" do
        # Trigger the behavior that occurs when invalid params are submitted
        Timeframe.any_instance.stub(:save).and_return(false)
        post :create, {:timeframe => {}}, valid_session
        assigns(:timeframe).should be_a_new(Timeframe)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Timeframe.any_instance.stub(:save).and_return(false)
        post :create, {:timeframe => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested timeframe" do
        timeframe = Timeframe.create! valid_attributes
        # Assuming there are no other timeframes in the database, this
        # specifies that the Timeframe created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Timeframe.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => timeframe.to_param, :timeframe => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested timeframe as @timeframe" do
        timeframe = Timeframe.create! valid_attributes
        put :update, {:id => timeframe.to_param, :timeframe => valid_attributes}, valid_session
        assigns(:timeframe).should eq(timeframe)
      end

      it "redirects to the timeframe" do
        timeframe = Timeframe.create! valid_attributes
        put :update, {:id => timeframe.to_param, :timeframe => valid_attributes}, valid_session
        response.should redirect_to(timeframe)
      end
    end

    describe "with invalid params" do
      it "assigns the timeframe as @timeframe" do
        timeframe = Timeframe.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Timeframe.any_instance.stub(:save).and_return(false)
        put :update, {:id => timeframe.to_param, :timeframe => {}}, valid_session
        assigns(:timeframe).should eq(timeframe)
      end

      it "re-renders the 'edit' template" do
        timeframe = Timeframe.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Timeframe.any_instance.stub(:save).and_return(false)
        put :update, {:id => timeframe.to_param, :timeframe => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested timeframe" do
      timeframe = Timeframe.create! valid_attributes
      expect {
        delete :destroy, {:id => timeframe.to_param}, valid_session
      }.to change(Timeframe, :count).by(-1)
    end

    it "redirects to the timeframes list" do
      timeframe = Timeframe.create! valid_attributes
      delete :destroy, {:id => timeframe.to_param}, valid_session
      response.should redirect_to(timeframes_url)
    end
  end

end
