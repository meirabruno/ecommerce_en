var productsContainer = $('#products-container');

if (productsContainer[0]) {
  $('.js-check-product').click(function(){
    var products_checkeds_count = count_checkeds();

    document.getElementById("js-count-selected").innerHTML = products_checkeds_count;

    toggle_display_remove_button(products_checkeds_count);
  });

  $('.js-remove-products').click(function(){
    var products_ids = get_checkeds_ids();

    remove_products(products_ids);

    count_checkeds();
  });

  $('.js-check-all-product').click(function(){
    select_all_products();
  });

  function toggle_display_remove_button(products_checkeds_count) {
    if (products_checkeds_count == "0") {
      $('.js-remove-products-button').addClass('d-none');
    } else {
      $('.js-remove-products-button').removeClass('d-none');
    }
  }

  function count_checkeds() {
    return $('.js-check-product:checked').length;
  }

  function get_checkeds_ids() {
    var ids = [];
    $('.js-check-product:checked').each(function (index) {
      var id = this.dataset['productId'];
      ids.push(id)
    });
    return ids;
  }

  function remove_products(products_ids) {
    $.ajax({
      url: "/remove-products",
      dataType: 'json',
      data: {
        ids: products_ids
      },
      type: 'DELETE',
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
      success: function (data) {
        products_ids.forEach(function (e) {
          document.getElementById('product-' + e).remove();
        });
      },
      error: function (data) {},
      complete: function (data) {}
    });
  }

  function select_all_products() {
    $('.js-check-product').each(function (index) {
      this.click();
    });
  }
}