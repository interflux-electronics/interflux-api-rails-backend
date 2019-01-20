class ApplicationController < ActionController::API
  include Errors

  def status
    git_branch = ENV['GIT_BRANCH'] || 'not-set'
    git_revision = ENV['GIT_REVISION'] || 'not-set'
    json = {
      code: 200,
      msg: 'This request successfully got passed Nginx, SSL, Rack, Rails and back! Have a cookie.',
      'git-branch': git_branch,
      'git-revision': git_revision
    }
    render status: 200, json: json
  end
end
