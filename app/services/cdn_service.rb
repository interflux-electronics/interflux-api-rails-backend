# This service wraps all interactions we want to make with our CDN.
# The Interflux CDN is S3 compliant bucket at Digital Ocean.
# We use the gem 'aws-sdk-s3' to interact with it.
#
# Documentation:
# https://docs.digitalocean.com/reference/api/spaces-api/
# https://docs.digitalocean.com/products/spaces/reference/s3-sdk-examples/#list-all-files-in-a-bucket
#
class CdnService
  # Lists all the files which start with given path.
  def list(path)
    files = []
    done = false
    next_marker = nil
    i = 0

    until done
      i += 1

      options = {
        bucket: bucket,
        prefix: path,
        marker: next_marker
      }.compact

      response = client.list_objects(options)

      files = [*files, *response.contents.pluck(:key)]
      next_marker = response.next_marker
      done = next_marker.nil?
    end

    files
  end

  # Downloads a CDN file to local.
  # https://docs.digitalocean.com/products/spaces/reference/s3-sdk-examples/#download-a-file-from-a-bucket
  def download(from:, to:)
    client.get_object(
      bucket: bucket,
      key: from,
      response_target: to
    )

    :done
  end

  # Uploads a local file to the CDN.
  # https://docs.digitalocean.com/products/spaces/reference/s3-sdk-examples/#upload-a-file-to-a-bucket
  def upload(from:, to:)
    client.put_object(
      {
        body: IO.read(from),
        key: to,
        bucket: bucket,
        acl: 'public-read'
      }
    )

    :done
  end

  # Deletes a single file.
  def delete(path)
    options = {
      bucket: bucket,
      key: path
    }.compact

    response = client.delete_object(options)

    success
  end

  private

  def success
    true
  end

  def bucket
    ENV['DO_BUCKET']
  end

  def client
    Aws::S3::Client.new(
      access_key_id: ENV['DO_ACCESS'],
      secret_access_key: ENV['DO_SECRET'],
      endpoint: ENV['DO_ENDPOINT'],
      force_path_style: false,
      region: ENV['DO_REGION']
    )
  end
end
