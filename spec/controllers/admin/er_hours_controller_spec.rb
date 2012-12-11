
require 'spec_helper'

describe Admin::ErHoursController do
  def valid_attributes
    FactoryGirl.attributes_for(:er_hour).merge(semester_id: @semester.id)
  end

  before do
    signin_as("admin")
    @semester = FactoryGirl.create(:semester)
  end

  describe "GET new" do
    it "assigns a new er_hour as @er_hour" do
      get :new, {semester_id: @semester.id}
      assigns(:er_hour).should be_a_new(ErHour)
    end
  end

  describe "GET edit" do
    it "assigns the requested er_hour as @er_hour" do
      er_hour = ErHour.create! valid_attributes
      get :edit, {semester_id: @semester.id, id: er_hour.to_param}
      assigns(:er_hour).should eq(er_hour)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ErHour" do
        expect {
          post :create, {semester_id: @semester.id, er_hour: valid_attributes}
        }.to change(ErHour, :count).by(1)
      end

      it "assigns a newly created er_hour as @er_hour" do
        post :create, {semester_id: @semester.id, er_hour: valid_attributes}
        assigns(:er_hour).should be_a(ErHour)
        assigns(:er_hour).should be_persisted
      end

      it "redirects to the created er_hour" do
        post :create, {semester_id: @semester.id, er_hour: valid_attributes}
        response.should redirect_to(edit_admin_semester_path(@semester))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved er_hour as @er_hour" do
        # Trigger the behavior that occurs when invalid params are submitted
        ErHour.any_instance.stub(:save).and_return(false)
        post :create, {semester_id: @semester.id, er_hour: {}}
        assigns(:er_hour).should be_a_new(ErHour)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ErHour.any_instance.stub(:save).and_return(false)
        post :create, {semester_id: @semester.id, er_hour: {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested er_hour" do
        er_hour = ErHour.create! valid_attributes
        # Assuming there are no other er_hours in the database, this
        # specifies that the ErHour created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ErHour.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {semester_id: @semester.id, id: er_hour.to_param, er_hour: {'these' => 'params'}}
      end

      it "assigns the requested er_hour as @er_hour" do
        er_hour = ErHour.create! valid_attributes
        put :update, {semester_id: @semester.id, id: er_hour.to_param, er_hour: valid_attributes}
        assigns(:er_hour).should eq(er_hour)
      end

      it "redirects to the er_hour" do
        er_hour = ErHour.create! valid_attributes
        put :update, {semester_id: @semester.id, id: er_hour.to_param, er_hour: valid_attributes}
        response.should redirect_to(edit_admin_semester_path(@semester))
      end
    end

    describe "with invalid params" do
      it "assigns the er_hour as @er_hour" do
        er_hour = ErHour.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ErHour.any_instance.stub(:save).and_return(false)
        put :update, {semester_id: @semester.id, id: er_hour.to_param, er_hour: {}}
        assigns(:er_hour).should eq(er_hour)
      end

      it "re-renders the 'edit' template" do
        er_hour = ErHour.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ErHour.any_instance.stub(:save).and_return(false)
        put :update, {semester_id: @semester.id, id: er_hour.to_param, er_hour: {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested er_hour" do
      er_hour = ErHour.create! valid_attributes
      expect {
        delete :destroy, {semester_id: @semester.id, id: er_hour.to_param}
      }.to change(ErHour, :count).by(-1)
    end

    it "redirects to the er_hours list" do
      er_hour = ErHour.create! valid_attributes
      delete :destroy, {semester_id: @semester.id, id: er_hour.to_param}
      response.should redirect_to(edit_admin_semester_path(@semester))
    end
  end
end
