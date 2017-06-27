alert_modal = function(title, message, message_class) {
  $('.modal').modal('hide');
  $('body').append(alert_modal_text(title, message, message_class));
  $("#alert_modal").modal("show");
  $("#alert_modal").on("hidden.bs.modal", function(){$(this).remove();});
};

var alert_modal_text = function(title, message, message_class) {

  message_class = message_class || 'danger'

return '  <div id="alert_modal" class="modal  in" tabindex="-1" style="display: block;"> \
            <div class="modal-dialog "> \
              <div class="modal-content"> \
                <div class="modal-header alert-' + message_class + '"> \
                  <button type="button" class="close" title="Close" data-dismiss="modal"><span>×</span></button> \
                  <div class="modal-title"> \
                    <span><i class="fa fa-exclamation"></i><span>&nbsp;' + title + '</span></span> \
                  </div> \
                </div> \
                <div class="modal-body alert-' + message_class + '"> \
                ' + message.split("\n").join("<br>") + ' \
                </div> \
              </div> \
            </div> \
          </div>';
};
