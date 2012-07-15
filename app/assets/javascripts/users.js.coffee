$('.btn').click( ->
  ($ @).addClass('disabled')
  ($ @).attr('value', 'Подождите...')
)
$('.chzn-select').chosen()