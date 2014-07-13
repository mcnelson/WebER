require 'spec_helper'

describe Admin::ErHoursController, type: :controller do
  render_views

  before { signin_as("admin") }

  describe "#new" do
    let(:semester) { create(:semester) }

    it "renders the new form" do
      get :new, {semester_id: semester}
      expect(assigns(:er_hour)).to be_a_new(ErHour)
    end
  end

  describe "#edit" do
    let(:semester) { create(:semester) }
    let(:er_hour)  { create(:er_hour, semester: semester) }

    it "renders an edit form" do
      get :edit, {semester_id: semester, id: er_hour.to_param}

      expect(assigns(:er_hour)).to  eql(er_hour)
      expect(response).to           render_template("edit")
    end
  end

  describe "#create" do
    let(:semester) { create(:semester) }

    context "with valid params" do
      it "creates a new ER hour" do
        expect {
          post :create, {semester_id: semester, er_hour: attributes_for(:er_hour)}
        }.to change(ErHour, :count).by(1)

        expect(assigns(:er_hour)).to be_a(ErHour)
        expect(assigns(:er_hour)).to be_persisted
        expect(response).to redirect_to(edit_admin_semester_path(semester))
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      let(:invalid_attrs) do
        attributes_for(:er_hour).tap do |a|
          a[:wday] = ""
        end
      end

      it "re-renders the form" do
        post :create, {semester_id: semester, er_hour: invalid_attrs}
        expect(assigns(:er_hour)).to be_a_new(ErHour)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    let(:semester) { create(:semester) }
    let(:er_hour) { create(:er_hour, semester: semester) }

    context "with valid params" do
      it "updates the requested er_hour" do
        put :update, {semester_id: semester, id: er_hour, er_hour: attributes_for(:er_hour)}
        expect(assigns(:er_hour)).to  eql(er_hour)
        expect(response).to           redirect_to(edit_admin_semester_path(semester))
        expect(flash[:success]).to    be_present
      end
    end

    context "with invalid params" do
      let(:invalid_attrs) do
        attributes_for(:er_hour).tap do |a|
          a[:wday] = ""
        end
      end

      it "rerenders the form" do
        put :update, {semester_id: semester, id: er_hour, er_hour: invalid_attrs}
        expect(assigns(:er_hour)).to eql(er_hour)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    let(:semester) { create(:semester) }
    let(:er_hour)  { create(:er_hour, semester: semester) }

    it "destroys the requested er_hour" do
      er_hour # create it

      expect {
        delete :destroy, {semester_id: semester, id: er_hour}
      }.to change(ErHour, :count).by(-1)

      expect(response).to redirect_to(edit_admin_semester_path(semester))
    end
  end
end
