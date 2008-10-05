require 'test_helper'

class NotationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:notations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_notation
    assert_difference('Notation.count') do
      post :create, :notation => { }
    end

    assert_redirected_to notation_path(assigns(:notation))
  end

  def test_should_show_notation
    get :show, :id => notations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => notations(:one).id
    assert_response :success
  end

  def test_should_update_notation
    put :update, :id => notations(:one).id, :notation => { }
    assert_redirected_to notation_path(assigns(:notation))
  end

  def test_should_destroy_notation
    assert_difference('Notation.count', -1) do
      delete :destroy, :id => notations(:one).id
    end

    assert_redirected_to notations_path
  end
end
