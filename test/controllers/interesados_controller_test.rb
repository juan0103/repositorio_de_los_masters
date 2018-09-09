require 'test_helper'

class InteresadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interesado = interesados(:one)
  end

  test "should get index" do
    get interesados_url
    assert_response :success
  end

  test "should get new" do
    get new_interesado_url
    assert_response :success
  end

  test "should create interesado" do
    assert_difference('Interesado.count') do
      post interesados_url, params: { interesado: { desc_interesado: @interesado.desc_interesado, id_interesado: @interesado.id_interesado } }
    end

    assert_redirected_to interesado_url(Interesado.last)
  end

  test "should show interesado" do
    get interesado_url(@interesado)
    assert_response :success
  end

  test "should get edit" do
    get edit_interesado_url(@interesado)
    assert_response :success
  end

  test "should update interesado" do
    patch interesado_url(@interesado), params: { interesado: { desc_interesado: @interesado.desc_interesado, id_interesado: @interesado.id_interesado } }
    assert_redirected_to interesado_url(@interesado)
  end

  test "should destroy interesado" do
    assert_difference('Interesado.count', -1) do
      delete interesado_url(@interesado)
    end

    assert_redirected_to interesados_url
  end
end
