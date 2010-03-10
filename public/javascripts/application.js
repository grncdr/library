// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function ajax_response(response){
  attrs = response.responseJSON;
}

function lookup(form){
  isbn = form.book_isbn.value;
  new Ajax.Request("/books/lookup.json?isbn="+isbn, {method: 'get', onComplete: (function(response){
          attrs = response.responseJSON;
          form.book_title.value     = attrs.title;
          form.book_summary.value   = attrs.summary;
          form.book_author.value    = attrs.author;
          form.book_publisher.value = attrs.publisher;
          form.book_edition.value   = attrs.edition;
          form.book_cover_url.value  = attrs.cover_url;
        }
        )});
};

