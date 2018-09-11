require 'test_helper'

class TipoDeNovedadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipo_de_novedade = tipo_de_novedades(:one)
  end

  test "should get index" do
    get tipo_de_novedades_url
    assert_response :success
  end

  test "should get new" do
    get new_tipo_de_novedade_url
    assert_response :success
  end

  test "should create tipo_de_novedade" do
    assert_difference('TipoDeNovedade.count') do
      post tipo_de_novedades_url, params: { tipo_de_novedade: { desc_tnovedad: @tipo_de_novedade.desc_tnovedad, id_tnovedad: @tipo_de_novedade.id_tnovedad } }
    end

    assert_redirected_to tipo_de_novedade_url(TipoDeNovedade.last)
  end

  test "should show tipo_de_novedade" do
    get tipo_de_novedade_url(@tipo_de_novedade)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipo_de_novedade_url(@tipo_de_novedade)
    assert_response :success
  end

  test "should update tipo_de_novedade" do
    patch tipo_de_novedade_url(@tipo_de_novedade), params: { tipo_de_novedade: { desc_tnovedad: @tipo_de_novedade.desc_tnovedad, id_tnovedad: @tipo_de_novedade.id_tnovedad } }
    assert_redirected_to tipo_de_novedade_url(@tipo_de_novedade)
  end

  test "should destroy tipo_de_novedade" do
    assert_difference('TipoDeNovedade.count', -1) do
      delete tipo_de_novedade_url(@tipo_de_novedade)
    end

    assert_redirected_to tipo_de_novedades_url
  end
end
