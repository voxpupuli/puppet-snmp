RSpec.shared_examples 'apply_manifest_twice' do |manifest|

  it 'applies the manifest twice' do
    apply_manifest(manifest, catch_failures: true)
    apply_manifest(manifest, catch_changes: true)
  end

end
