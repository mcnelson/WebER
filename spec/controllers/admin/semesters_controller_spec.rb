require 'spec_helper'

describe Admin::SemestersController do
  def valid_attributes
    FactoryGirl.attributes_for(:semester)
  end

  before do
    signin_as_admin
  end

  describe "GET index" do
    it "assigns all semesters as @semesters" do
      semester = Semester.create! valid_attributes
      get :index, {}
      assigns(:semesters).should eq([semester])
    end
  end

  describe "GET show" do
    it "assigns the requested semester as @semester" do
      semester = Semester.create! valid_attributes
      get :show, {:id => semester.to_param}
      assigns(:semester).should eq(semester)
    end
  end

  describe "GET new" do
    it "assigns a new semester as @semester" do
      get :new, {}
      assigns(:semester).should be_a_new(Semester)
    end
  end

  describe "GET edit" do
    it "assigns the requested semester as @semester" do
      semester = Semester.create! valid_attributes
      get :edit, {:id => semester.to_param}
      assigns(:semester).should eq(semester)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Semester" do
        expect {
          post :create, {:semester => valid_attributes}
        }.to change(Semester, :count).by(1)
      end

      it "assigns a newly created semester as @semester" do
        post :create, {:semester => valid_attributes}
        assigns(:semester).should be_a(Semester)
        assigns(:semester).should be_persisted
      end

      it "redirects to the created semester" do
        post :create, {:semester => valid_attributes}
        response.should redirect_to([:admin, Semester.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved semester as @semester" do
        # Trigger the behavior that occurs when invalid params are submitted
        Semester.any_instance.stub(:save).and_return(false)
        post :create, {:semester => {}}
        assigns(:semester).should be_a_new(Semester)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Semester.any_instance.stub(:save).and_return(false)
        post :create, {:semester => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested semester" do
        semester = Semester.create! valid_attributes
        # Assuming there are no other semesters in the database, this
        # specifies that the Semester created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Semester.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => semester.to_param, :semester => {'these' => 'params'}}
      end

      it "assigns the requested semester as @semester" do
        semester = Semester.create! valid_attributes
        put :update, {:id => semester.to_param, :semester => valid_attributes}
        assigns(:semester).should eq(semester)
      end

      it "redirects to the semester" do
        semester = Semester.create! valid_attributes
        put :update, {:id => semester.to_param, :semester => valid_attributes}
        response.should redirect_to([:admin, semester])
      end
    end

    describe "with invalid params" do
      it "assigns the semester as @semester" do
        semester = Semester.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Semester.any_instance.stub(:save).and_return(false)
        put :update, {:id => semester.to_param, :semester => {}}
        assigns(:semester).should eq(semester)
      end

      it "re-renders the 'edit' template" do
        semester = Semester.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Semester.any_instance.stub(:save).and_return(false)
        put :update, {:id => semester.to_param, :semester => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested semester" do
      semester = Semester.create! valid_attributes
      expect {
        delete :destroy, {:id => semester.to_param}
      }.to change(Semester, :count).by(-1)
    end

    it "redirects to the semesters list" do
      semester = Semester.create! valid_attributes
      delete :destroy, {:id => semester.to_param}
      response.should redirect_to(admin_semesters_path)
    end
  end

end
