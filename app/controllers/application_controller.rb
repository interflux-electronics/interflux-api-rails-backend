class ApplicationController < ActionController::API
  include Errors

  def status
    json = {
      code: 200,
      msg: 'This request successfully got passed Nginx, SSL, Rack, Rails and back! Have a beer.',
      'git-branch': ENV.fetch('GIT_BRANCH'),
      'git-revision': ENV.fetch('GIT_REVISION')
    }
    render status: 200, json: json
  end
end
