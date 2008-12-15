require 'test_helper'

class HowtosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:howtos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_howto
    assert_difference('Howto.count') do
      post :create, :howto => { }
    end

    assert_redirected_to howto_path(assigns(:howto))
  end

  def test_should_show_howto
    get :show, :id => howtos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => howtos(:one).id
    assert_response :success
  end

  def test_should_update_howto
    put :update, :id => howtos(:one).id, :howto => { }
    assert_redirected_to howto_path(assigns(:howto))
  end

  def test_should_destroy_howto
    assert_difference('Howto.count', -1) do
      delete :destroy, :id => howtos(:one).id
    end

    assert_redirected_to howtos_path
  end
end
