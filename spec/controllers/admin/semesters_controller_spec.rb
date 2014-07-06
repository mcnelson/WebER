require 'spec_helper'

describe Admin::SemestersController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe "#index" do
    let!(:semester) { create(:semester) }

    it "assigns all semesters as @semesters" do
      get :index
      assigns(:semesters).should eq([semester])
    end
  end

  describe "#show" do
    let!(:semester) { create(:semester) }

    it "assigns the requested semester as @semester" do
      get :show, id: semester
      assigns(:semester).should eq(semester)
    end
  end

  describe "#new" do
    it "assigns a new semester as @semester" do
      get :new
      assigns(:semester).should be_a_new(Semester)
    end
  end

  describe "#edit" do
    let(:semester) { create(:semester) }

    it "assigns the requested semester as @semester" do
      get :edit, id: semester
      assigns(:semester).should eq(semester)
    end
  end

  describe "#create" do
    describe "with valid params" do
      it "creates a new Semester" do
        expect {
          post :create, semester: attributes_for(:semester)
        }.to change(Semester, :count).by(1)
      end

      it "assigns a newly created semester as @semester" do
        post :create, semester: attributes_for(:semester)

        expect(assigns(:semester)).to be_a(Semester)
        expect(assigns(:semester)).to be_persisted
        expect(response).to redirect_to([:admin, Semester.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved semester as @semester" do
        post :create, semester: {starts_at: "blah"}

        expect(assigns(:semester)).to be_a_new(Semester)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    let(:semester) { create(:semester) }

    describe "with valid params" do
      it "updates the requested semester" do
        put :update, id: semester, semester: attributes_for(:semester)
        response.should redirect_to([:admin, semester])
      end
    end

    describe "with invalid params" do
      let(:semester) { create(:semester) }

      it "assigns the semester as @semester" do
        put :update, id: semester, semester: {starts_at: "blah"}
        assigns(:semester).should eq(semester)
        response.should render_template("edit")
      end
    end
  end
end
