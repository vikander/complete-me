angular.module 'completeMe'
  .controller 'CommentsController', ($scope, $timeout, $sce, webDevTec, toastr) ->
    'ngInject'
    vm = this




    activate = ->
      getWebDevTec()
      $timeout (->
        vm.classAnimation = 'rubberBand'
        return
      ), 4000
      return



    showToastr = ->
      toastr.info 'Fork <a href="https://github.com/Swiip/generator-gulp-angular" target="_blank"><b>generator-gulp-angular</b></a>'
      vm.classAnimation = ''
      return

    getWebDevTec = ->
      vm.awesomeThings = webDevTec.getTec()
      angular.forEach vm.awesomeThings, (awesomeThing) ->
        awesomeThing.rank = Math.random()
        return
      return

    vm.parseContent = (content) ->
      $sce.trustAsHtml content

    vm.isAuthor = (email) ->
      email == authorEmail

    vm.getGravatar = (email) ->
      hash = undefined
      if email == undefined
        email = ''
      hash = email.trim()
      hash = hash.toLowerCase()
      hash = md5(hash)
      '//gravatar.com/avatar/' + hash + '?s=104&d=identicon'


    vm.loveComment = (commentId) ->
      comment = undefined
      i = undefined
      len = undefined
      ref = undefined
      results = undefined
      ref = vm.comments
      results = []
      i = 0
      len = ref.length
      while i < len
        comment = ref[i]
        if comment.id == commentId
          results.push comment.loved = !comment.loved
        else
          results.push undefined
        i++
      results

    vm.addReply = (author) ->
      if vm.newComment.content == undefined
        vm.newComment.content = ''
      if vm.newComment.content.search('@' + author + '@') == -1
        if vm.newComment.content[0] == '@'
          vm.newComment.content = ', ' + vm.newComment.content
        else
          vm.newComment.content = ' ' + vm.newComment.content
        return vm.newComment.content = '@' + author + '@' + vm.newComment.content
      return

    vm.addNewComment = ->
      vm.newComment.id = vm.comments.length + 1
      vm.newComment.author.website = vm.newComment.author.website.replace(/https?:\/\/(www.)?/g, '')
      vm.newComment.content = markdown(vm.newComment.content)
      vm.newComment.loved = false
      vm.comments.push vm.newComment
      vm.newComment = {}

    $scope.$watch 'vm.newComment.email', (newValue, oldValue) ->
      newCommentAvatar = undefined
      newCommentAvatar = document.getElementById('newCommentAvatar')
      newCommentAvatar.src = vm.getGravatar(vm.newComment.email)


    authorEmail = 'yim.apichai@gmail.com'

    vm.comments = [
      {
        id: 1
        author:
          name: 'Jan-Kanty Pawelski'
          email: 'jan.kanty.pawelski@gmail.com'
          website: 'pawelski.io'
        content: 'I made it! My awesome angular comment system. What do you think?'
        loved: false
      }
      {
        id: 2
        author:
          name: 'Tomasz Jakut'
          email: 'comandeer@comandeer.pl'
          website: 'comandeer.pl'
        content: 'Nice looking. Good job dude ;)'
        loved: true
      }
      {
        id: 3
        author:
          name: 'Jan-Kanty Pawelski'
          email: 'jan.kanty.pawelski@gmail.com'
          website: 'pawelski.io'
        content: '<span class="reply">@Tomasz Jakut</span> Thanks man. I tried hard.'
        loved: false
      }
      {
        id: 4
        author:
          name: 'Grzegorz Bąk'
          email: 'szary.elf@gmail.com'
          website: 'gregbak.com'
        content: 'Third! Amazing system man! By the way check my new website: <a href="//gregbak.com">http://gregbak.com</a>.'
        loved: false
      }
    ]

    vm.newComment = {}
    vm.classAnimation = ''
    vm.creationDate = 1452754477846
    vm.showToastr = showToastr
    activate()
    return
