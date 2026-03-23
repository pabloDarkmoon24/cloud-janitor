# jreleaser.yml - Complete JReleaser configuration with Homebrew support

project:
  name: cloud-janitor
  version: 1.0.0
  description: A convenience tool to automate operations in cloud computing
  longDescription: |
    Cloud Janitor is a convenience tool to automate operations in cloud computing,
    like creating clusters or cleaning up accounts. It provides intent resolution,
    improved security, and is easy to run and configure.
  website: https://github.com/CaravanaCloud/cloud-janitor
  authors:
    - CaravanaCloud
  license: Apache-2.0
  inceptionYear: 2022
  tags:
    - cloud
    - automation
    - janitor
    - devops
  java:
    version: 11
    groupId: cloud.caravana
    artifactId: cloud-janitor

release:
  github:
    owner: CaravanaCloud
    name: cloud-janitor
    overwrite: true
    draft: false
    prerelease:
      enabled: false
    changelog:
      formatted: ALWAYS
      preset: conventional-commits
      contributors:
        enabled: true

packagers:
  brew:
    active: ALWAYS
    continueOnError: false
    formulaName: CloudJanitor
    multiPlatform: true
    tap:
      owner: CaravanaCloud
      name: homebrew-tap
      branch: main
      commitMessage: 'brew: {{projectName}} {{projectVersion}}'
      username: '{{env.GITHUB_USERNAME}}'
      token: '{{secrets.GITHUB_TOKEN}}'
    dependencies:
      - name: openjdk@17
        type: optional
    downloadUrl: 'https://github.com/CaravanaCloud/cloud-janitor/releases/download/v{{projectVersion}}/{{artifactFileName}}'
    templateDirectory: src/jreleaser/templates/brew

distributions:
  cloud-janitor:
    type: JAVA_BINARY
    brew:
      active: ALWAYS
      formulaName: CloudJanitor
    tags:
      - cloud-janitor
      - cloud
      - automation
    executable:
      name: cloud-janitor
      windowsExtension: bat
    artifacts:
      - path: 'target/cloud-janitor-{{projectVersion}}-runner'
        platform: linux-x86_64
      - path: 'target/cloud-janitor-{{projectVersion}}-runner'
        platform: osx-x86_64
      - path: 'target/cloud-janitor-{{projectVersion}}-runner'
        platform: osx-aarch_64

---
# src/jreleaser/templates/brew/formula.rb.tpl
# Homebrew Formula Template

class CloudJanitor < Formula
  desc "{{projectDescription}}"
  homepage "{{projectWebsite}}"
  version "{{projectVersion}}"
  license "{{projectLicense}}"

  on_macos do
    if Hardware::CPU.arm?
      url "{{distributionUrl}}"
      sha256 "{{sha256}}"
    else
      url "{{distributionUrl}}"
      sha256 "{{sha256}}"
    end
  end

  on_linux do
    url "{{distributionUrl}}"
    sha256 "{{sha256}}"
  end

  depends_on "openjdk@17" => :optional

  def install
    bin.install "cloud-janitor"
  end

  test do
    system "#{bin}/cloud-janitor", "--version"
  end
end