// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sweet-alert
//= require jquery
//= require jquery_ujs
//= require sweet-alert-confirm
//= require turbolinks
//= require bootstrap-sprockets
//= require selectize
//= require bootstrap-datepicker
//= require bootstrap-datepicker.zh-CN
//= require summernote
//= require jquery.dataTables.min
//= require dataTables.bootstrap.min
//= require dataTables.buttons.min
//= require dataTables.scroller.min
//= require buttons.bootstrap.min
//= require buttons.flash.min
//= require buttons.html5.min
//= require buttons.print.min
//= require masonry/masonry.min
//= require moment
//= require bootstrap-tagsinput
//= require moment/zh-cn
//= require_tree .


$(window).bind('page:change', function() {
    initPage();
});

function initPage() {
    $('.sidebar .list-group-item').click(function(){
        $(this).find('i.fa').remove();
        $(this).prepend('<i class="fa fa-spinner fa-spin fa-fw"></i>');
        return true;
    });
    $('#menu-toggle').click(function(e) {
        $('#wrapper').toggleClass('toggled');
    });

    $('.fromNow').each(function() {
        if ($(this).text().trim() != '') {
            $(this).text(moment($(this).text()).fromNow())
        }
    })

    var mc = $('.masonry-container');
    mc.masonry({
        columnWidth: '.item',
        itemSelector: '.item'
    })

    // $('.datepicker').datepicker({
    //   format: 'yyyy-mm-dd',
    //   autoclose:true,
    //   language:'zh-CN'
    // })

    $('.panel').fadeIn(1000);
    $('.panel').hover(function() {
        $(this).find('.actions').fadeIn(500);
    });
    $('.panel').mouseleave(function() {
        $(this).find('.actions').fadeOut(200);
    });

    // item
    $('.item').hover(function() {
        $(this).find('.actions').fadeIn(500);
    });
    $('.item').mouseleave(function() {
        $(this).find('.actions').fadeOut(200);
    });


    // tooltip
    $('[data-toggle="tooltip"]').tooltip();
    // end of tooltip

    // popover
    // $('[data-toggle="popover"]').popover({html:true})
    // end of popover

    var dontSort = [];
    var hidden = [];
    var order = [];
    var sumIndex = -1;
    var sumType = 'count';
    $('.datatable thead th').each(function(index, elem) {
        // for sum up
        if ($(this).hasClass('sum_up')) {
            sumIndex = index;
            if ($(this).hasClass('rmb')) {
                sumType = 'rmb';
            }
        }
        // for no sort
        if ($(this).hasClass('no_sort')) {
            dontSort.push({
                "bSortable": false
            });
        } else {
            dontSort.push(null);
        }

        if ($(this).hasClass('hidden')) {
            hidden.push({
                "targets": [index],
                "visible": false
            });
        }

        if ($(this).hasClass('asc')) {
            var count = $(this).prevAll('th').size();
            order.push([count, "asc"]);
        }
        // "order": [[ 3, "desc" ]]
    });
    if (! $.fn.dataTable.isDataTable('.datatable')){

        $('.datatable').DataTable({
            buttons:[
            {extend: 'excel', text: 'Excel', exportOptions: { modifier: { selected: true }}}
            , 'print'
        ],
        "sDom": '<"row view-filter"<"col-sm-12"<"pull-left"l><"pull-right"<"inline-block mr-20"B><"inline-block"f>><"clearfix">>>t<"row"<"col-sm-12 text-center"<"total-footer">>><"row view-pager"<"col-sm-12"<"pagination-wrapper"p>>>',
        "aoColumns": dontSort,
        "autoWidth": false,
        "aaSorting": [],
        "columnDefs": hidden,
        order: order,
        language:{
        "sProcessing":   "处理中...",
        "sLengthMenu":   "显示 _MENU_ 项结果",
        "sZeroRecords":  "没有匹配结果",
        "sInfo":         "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
        "sInfoEmpty":    "显示第 0 至 0 项结果，共 0 项",
        "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
        "sInfoPostFix":  "",
        "sSearch":       "搜索:",
        "sUrl":          "",
        "sEmptyTable":     "表中数据为空",
        "sLoadingRecords": "载入中...",
        "sInfoThousands":  ",",
        "oPaginate": {
          "sFirst":    "首页",
          "sPrevious": "上页",
          "sNext":     "下页",
          "sLast":     "末页"
        },
        "oAria": {
          "sSortAscending":  ": 以升序排列此列",
          "sSortDescending": ": 以降序排列此列"
        }
      },
        "footerCallback": function(row, data, start, end, display) {
            if (sumIndex >= 0) {
                var api = this.api();

                // Remove the formatting to get integer data for summation
                var intVal = function(i) {
                    return typeof i === 'string' ?
                        i.replace(/[￥ ]/g, '') * 1 :
                        typeof i === 'number' ?
                        i : 0;
                };

                // Total over all pages
                total = api
                    .column(sumIndex)
                    .data()
                    .reduce(function(a, b) {
                        return intVal(a) + intVal(b);
                    });

                // Total over this page
                pageTotal = api
                    .column(sumIndex, {
                        page: 'current'
                    })
                    .data()
                    .reduce(function(a, b) {
                        return intVal(a) + intVal(b);
                    }, 0);
                var totalStr = '';
                if (sumType == 'rmb') {
                    pageTotal = parseInt(pageTotal * 100) / 100.0;
                    total = parseInt(total * 100) / 100.0;
                    totalStr = '本页小计: ￥' + pageTotal + ' / 总计: ￥' + total;
                } else {
                    pageTotal = parseInt(pageTotal * 10) / 10.0;
                    total = parseInt(total * 10) / 10.0;
                    totalStr = '本页小计: ' + pageTotal + ' / 总计: ' + total;

                }

                $('.total-footer').html(totalStr);
                // Update footer
                // $( api.column( sumIndex ).footer() ).html(totalStr);
            }
        }
    });
    }
    // qiniu upload picture
    // powerd by 🍌
    sn = $('#summernote').summernote({
        height: 400,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'italic', 'underline', 'clear']],
            ['fontsize', ['fontsize']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['height', ['height']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'hr', 'video']],
            ['view', ['fullscreen', 'codeview']],
            ['help', ['help']],
        ],
        onImageUpload: function(files) {
            sendFile(files[0], $(this));
        },
        onChange: function() {
            var html = $('#summernote').code();
            console.log(html);
        }
    });

    var config = {
        height: 400,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'italic', 'underline', 'clear']],
            ['fontsize', ['fontsize']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['height', ['height']],
            ['table', ['table']],
            ['insert', ['link', 'hr']],
            ['view', ['fullscreen', 'codeview']],
            ['help', ['help']],
        ]
    }
    // $('#weekly_sumary').summernote(config);
    // $('#weekly_hope').summernote(config);
}

function sendFile(file, editor) {

    var filename = false;
    try {
        filename = file['name'];
    } catch (e) {
        filename = false;
    }
    if (!filename) {
        $(".note-alarm").remove();
    }
    //以上防止在图片在编辑器内拖拽引发第二次上传导致的提示错误
    var ext = filename.substr(filename.lastIndexOf("."));
    ext = ext.toUpperCase();
    var timestamp = new Date().getTime();
    var name = timestamp + ext;
    //name是文件名，自己随意定义，aid是我自己增加的属性用于区分文件用户
    data = new FormData();
    data.append("file", file);
    data.append("key", name);
    data.append("token", $("#summernote").attr('token'));
    $.ajax({
        data: data,
        type: "POST",
        url: "http://upload.qiniu.com",
        cache: false,
        contentType: false,
        processData: false,
        success: function(data) {
            var url = $("#summernote").attr('urlhead') + data['key'];
            editor.summernote('insertImage', url);
        },
        error: function() {
            sweetAlert("Oops", "图片上传失败，请重新上传");
        }
    });
}
