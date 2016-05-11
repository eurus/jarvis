config = {
  height: 400,
  toolbar: [
      ['style', ['style']],
      ['font', ['bold', 'italic', 'underline', 'clear']],
      ['fontsize', ['fontsize']],

      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['height', ['height']],
      ['table', ['table']],
      ['insert', ['link', 'hr']],
      ['view', ['fullscreen', 'codeview']],
      ['help', ['help']],
  ]
}
$(window).bind 'page:change', ->
  $('#weekly_sumary').summernote(config)
  $('#weekly_hope').summernote(config)
  $('#plan_description').summernote(config)
  imgs = $('article').find('img')
  for img in imgs
    $(img).addClass "img-responsive"

