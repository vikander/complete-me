angular.module 'completeMe'
  .controller 'CommentsController', ($scope, $timeout, $http, $activityIndicator, $q, $sce, webDevTec, toastr) ->
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
      vm.newComment.loved = false
      vm.comments.push vm.newComment
      vm.newComment = {}

    $scope.$watch 'vm.newComment.email', (newValue, oldValue) ->
      newCommentAvatar = undefined
      newCommentAvatar = document.getElementById('newCommentAvatar')
      newCommentAvatar.src = vm.getGravatar(vm.newComment.email)

    vm.searchPeople = (term) ->
      $activityIndicator.startAnimating()
      console.log '========='
      console.log term
      peopleList = []
      $http.get('https://raw.githubusercontent.com/vikander/complete-me/master/data.json').then (response) ->
        console.log response
        angular.forEach response.data, (item) ->
          if item.name.toUpperCase().indexOf(term.toUpperCase()) >= 0
            peopleList.push item
          return
        vm.people = peopleList
        $q.when peopleList

    vm.getPeopleText = (item) ->
      
      # note item.label is sent when the typedText wasn't found
      '@' + (item.name or item.label)

    authorEmail = 'yim.apichai@gmail.com'

    vm.macros =
      'wtf': 'what the fudge!?'
      'lol': 'lots of licks'
      '(smile)': '<img src="http://a248.e.akamai.net/assets.github.com/images/icons/emoji/smile.png"' + ' height="20" width="20">'


    vm.folks = [
      { label: 'Joe' }
      { label: 'Mike' }
      { label: 'Diane' }
    ]


    vm.comments = [
      {
        id: 1
        author:
          name: 'Yim Apichai'
          email: 'yim.apichai@gmail.com'
          website: 'http://skogman.github.io'
        content: 'I finished the assignment, I hope I did allright!'
        loved: false
      }
      {
        id: 2
        author:
          name: 'Lena Gunn'
          email: 'lenazun@hypothe.is'
          website: 'http://hypothes.is'
        content: 'Great! Let me evaluate your work...'
        loved: true
      }
      {
        id: 3
        author:
          name: 'Yim Apichai'
          email: 'yim.apichai@gmail.com'
          website: 'skogman.github.io'
        content: '<span class="reply">@Lena Gunn</span> Thanks, I appreciate it :)'
        loved: false
      }
      {
        id: 4
        author:
          name: 'Lena Gunn'
          email: 'lenazun@hypothe.is'
          website: 'http://hypothes.is'
        content: 'Congratulations, you got the job!'
        loved: false
      }
    ]

    vm.newComment = {}
    vm.classAnimation = ''
    vm.creationDate = 1452754477846
    vm.showToastr = showToastr
    activate()
    return

.filter 'words', ->
  (input, words) ->
    if isNaN(words)
      return input
    if words <= 0
      return ''
    if input
      inputWords = input.split(/\s+/)
      if inputWords.length > words
        input = inputWords.slice(0, words).join(' ') + '…'
    input

