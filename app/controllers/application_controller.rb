class ApplicationController < ActionController::API
  include JsonApi

  def status
    git_branch = ENV['GIT_BRANCH'] || 'unknown'
    git_revision = ENV['GIT_REVISION'] || 'unknown'
    json = {
      code: 200,
      msg: 'This request successfully got passed Nginx, SSL, Rack, Rails and back! Have a beer.',
      'git-branch': git_branch,
      'git-revision': git_revision
    }
    render status: 200, json: json
  end
end
