// likes.js

$(document).on('turbolinks:load', function() {
  $('.like-button').on('click', function(e) {
    e.preventDefault();
    var postId = $(this).data('post-id');
    
    $.ajax({
      type: 'POST',
      url: '/posts/' + postId + '/like',
      dataType: 'json',
      success: function(response) {
        // Update UI as needed (e.g., increment like count)
      },
      error: function(xhr, status, error) {
        console.error('Error:', error);
      }
    });
  });
});
