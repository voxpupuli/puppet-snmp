# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v7.2.0](https://github.com/voxpupuli/puppet-snmp/tree/v7.2.0) (2024-10-01)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v7.1.0...v7.2.0)

**Breaking changes:**

- Drop ubuntu 18.04 support [\#302](https://github.com/voxpupuli/puppet-snmp/pull/302) ([bastelfreak](https://github.com/bastelfreak))
- Drop FreeBSD 12 support [\#301](https://github.com/voxpupuli/puppet-snmp/pull/301) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Debian 10 [\#298](https://github.com/voxpupuli/puppet-snmp/pull/298) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL CentOS 8 [\#297](https://github.com/voxpupuli/puppet-snmp/pull/297) ([bastelfreak](https://github.com/bastelfreak))
- Drop EL7 support [\#296](https://github.com/voxpupuli/puppet-snmp/pull/296) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add support for Rocky and AlmaLinux [\#303](https://github.com/voxpupuli/puppet-snmp/pull/303) ([silug](https://github.com/silug))
- Add FreeBSD 14 support [\#300](https://github.com/voxpupuli/puppet-snmp/pull/300) ([bastelfreak](https://github.com/bastelfreak))
- Add Ubuntu 24.04 support [\#299](https://github.com/voxpupuli/puppet-snmp/pull/299) ([bastelfreak](https://github.com/bastelfreak))
- Add OracleLinux 8 / 9 support [\#295](https://github.com/voxpupuli/puppet-snmp/pull/295) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- update puppet-systemd upper bound to 8.0.0 [\#289](https://github.com/voxpupuli/puppet-snmp/pull/289) ([TheMeier](https://github.com/TheMeier))

## [v7.1.0](https://github.com/voxpupuli/puppet-snmp/tree/v7.1.0) (2024-01-24)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v7.0.0...v7.1.0)

**Merged pull requests:**

- Support puppet-systemd 5.x and 6.x [\#283](https://github.com/voxpupuli/puppet-snmp/pull/283) ([silug](https://github.com/silug))

## [v7.0.0](https://github.com/voxpupuli/puppet-snmp/tree/v7.0.0) (2024-01-12)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v6.0.0...v7.0.0)

**Breaking changes:**

- Drop Debian 9 support [\#272](https://github.com/voxpupuli/puppet-snmp/pull/272) ([traylenator](https://github.com/traylenator))
- Drop Puppet 6 support [\#270](https://github.com/voxpupuli/puppet-snmp/pull/270) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- add support for systemd on Ubuntu and improve it on Debian [\#281](https://github.com/voxpupuli/puppet-snmp/pull/281) ([hbog](https://github.com/hbog))
- Add Debian 12 \(bookworm\) support. [\#279](https://github.com/voxpupuli/puppet-snmp/pull/279) ([hbog](https://github.com/hbog))
- Add Puppet 8 support [\#274](https://github.com/voxpupuli/puppet-snmp/pull/274) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/stdlib: Allow 9.x [\#273](https://github.com/voxpupuli/puppet-snmp/pull/273) ([bastelfreak](https://github.com/bastelfreak))
- Add Ubuntu 22.04 support [\#268](https://github.com/voxpupuli/puppet-snmp/pull/268) ([skylar2-uw](https://github.com/skylar2-uw))
- bump puppet/systemd to \< 5.0.0 [\#266](https://github.com/voxpupuli/puppet-snmp/pull/266) ([jhoblitt](https://github.com/jhoblitt))
- Support CentOS 9 and RHEL 9 [\#260](https://github.com/voxpupuli/puppet-snmp/pull/260) ([kajinamit](https://github.com/kajinamit))
- Support Debian 11 Bullseye [\#259](https://github.com/voxpupuli/puppet-snmp/pull/259) ([antondollmaier](https://github.com/antondollmaier))
- Support CentOS 8 and RHEL 8 [\#258](https://github.com/voxpupuli/puppet-snmp/pull/258) ([kajinamit](https://github.com/kajinamit))

**Closed issues:**

- snmpd\_options and/or snmptrapd\_options are ignored on Ubuntu and Debian due to lack of systemd support [\#280](https://github.com/voxpupuli/puppet-snmp/issues/280)
- Support for Ubuntu 22.04 [\#263](https://github.com/voxpupuli/puppet-snmp/issues/263)
- snmpd starts on each puppet run [\#252](https://github.com/voxpupuli/puppet-snmp/issues/252)
- systemd daemon-reload restarts snmpd [\#244](https://github.com/voxpupuli/puppet-snmp/issues/244)
- Support Debian Bullseye 11 \(to be released in may or june\) [\#243](https://github.com/voxpupuli/puppet-snmp/issues/243)
- FreeBSD Support [\#238](https://github.com/voxpupuli/puppet-snmp/issues/238)
- To support CentOS 8 [\#217](https://github.com/voxpupuli/puppet-snmp/issues/217)

**Merged pull requests:**

- Set 'var-net-snmp' ensure to absent when removing snmp [\#267](https://github.com/voxpupuli/puppet-snmp/pull/267) ([AlexandarY](https://github.com/AlexandarY))
- Cleanup Debian Hieradata [\#257](https://github.com/voxpupuli/puppet-snmp/pull/257) ([ardichoke](https://github.com/ardichoke))
- Support FreeBSD and Darwin [\#239](https://github.com/voxpupuli/puppet-snmp/pull/239) ([geoffdavis](https://github.com/geoffdavis))

## [v6.0.0](https://github.com/voxpupuli/puppet-snmp/tree/v6.0.0) (2021-08-26)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v5.1.1...v6.0.0)

**Breaking changes:**

- Support Ubuntu 20.04; Drop EoL Debian 8, Ubuntu 16.04 [\#247](https://github.com/voxpupuli/puppet-snmp/pull/247) ([kenyon](https://github.com/kenyon))
- Drop Puppet 5 support; enable Puppet 7 support [\#242](https://github.com/voxpupuli/puppet-snmp/pull/242) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL CentOS 6 [\#237](https://github.com/voxpupuli/puppet-snmp/pull/237) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- puppetlabs/stdlib: Allow 7.x [\#241](https://github.com/voxpupuli/puppet-snmp/pull/241) ([bastelfreak](https://github.com/bastelfreak))
- camptocamp/systemd: allow 3.x [\#240](https://github.com/voxpupuli/puppet-snmp/pull/240) ([bastelfreak](https://github.com/bastelfreak))
- Support management of snmptrapd [\#234](https://github.com/voxpupuli/puppet-snmp/pull/234) ([elmobp](https://github.com/elmobp))
- Add parameters pass and pass\_persist. [\#233](https://github.com/voxpupuli/puppet-snmp/pull/233) ([olifre](https://github.com/olifre))

**Closed issues:**

- Doesn't work on ubuntu focal 20.04 [\#229](https://github.com/voxpupuli/puppet-snmp/issues/229)
- remove hardcoded group 'root' [\#206](https://github.com/voxpupuli/puppet-snmp/issues/206)

**Merged pull requests:**

- Allow stdlib 8.0.0 [\#248](https://github.com/voxpupuli/puppet-snmp/pull/248) ([smortex](https://github.com/smortex))
- switch from camptocamp/systemd to voxpupuli/systemd [\#245](https://github.com/voxpupuli/puppet-snmp/pull/245) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 3.0.0 & puppet-lint updates [\#230](https://github.com/voxpupuli/puppet-snmp/pull/230) ([bastelfreak](https://github.com/bastelfreak))

## [v5.1.1](https://github.com/voxpupuli/puppet-snmp/tree/v5.1.1) (2020-06-30)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v5.1.0...v5.1.1)

**Fixed bugs:**

- Dependency on stdlib versions incorrect for version 5.1.0 ; types/ip/address/v6/cidr.pp and type Stdlib::IP::Address::V6::CIDR does not exist in 4.25.0 [\#224](https://github.com/voxpupuli/puppet-snmp/issues/224)

## [v5.1.0](https://github.com/voxpupuli/puppet-snmp/tree/v5.1.0) (2020-04-18)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v5.0.0...v5.1.0)

**Implemented enhancements:**

- use systemd for debian 9 snmpd options [\#216](https://github.com/voxpupuli/puppet-snmp/pull/216) ([hdep](https://github.com/hdep))
- Support Debian 10 [\#214](https://github.com/voxpupuli/puppet-snmp/pull/214) ([antondollmaier](https://github.com/antondollmaier))

**Fixed bugs:**

- snmpd\_options parameter does not work with Debian 9 [\#110](https://github.com/voxpupuli/puppet-snmp/issues/110)

**Merged pull requests:**

- Use voxpupuli-acceptance [\#221](https://github.com/voxpupuli/puppet-snmp/pull/221) ([ekohl](https://github.com/ekohl))

## [v5.0.0](https://github.com/voxpupuli/puppet-snmp/tree/v5.0.0) (2020-01-22)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v4.1.0...v5.0.0)

After consulting with the community, it was decided **not** to remove traditional access control.  The feature had been marked as deprecated for a long time, (before Vox Pupuli took over maintenance). We have committed to keeping this feature (but still recommend using VACM instead).

**Breaking changes:**

- drop Ubuntu 14.04 support [\#208](https://github.com/voxpupuli/puppet-snmp/pull/208) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL FreeBSD and OpenBSD [\#200](https://github.com/voxpupuli/puppet-snmp/pull/200) ([Dan33l](https://github.com/Dan33l))
- modulesync 2.5.1 and drop Puppet 4 [\#177](https://github.com/voxpupuli/puppet-snmp/pull/177) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Provide a higher-level interface to snmpd [\#54](https://github.com/voxpupuli/puppet-snmp/issues/54)
- "Debian will not support the use of non-numeric OIDs" [\#16](https://github.com/voxpupuli/puppet-snmp/issues/16)
- Convert from params to data in module [\#181](https://github.com/voxpupuli/puppet-snmp/pull/181) ([ghoneycutt](https://github.com/ghoneycutt))

**Fixed bugs:**

- Dependancy listings are out of date [\#178](https://github.com/voxpupuli/puppet-snmp/issues/178)
- Failure to set authpass/privpass containing a dollar sign [\#173](https://github.com/voxpupuli/puppet-snmp/issues/173)
- rouser in snmpd.conf missing for v3 auth [\#9](https://github.com/voxpupuli/puppet-snmp/issues/9)
- Set snmpd stop command based on the node's default service provider [\#204](https://github.com/voxpupuli/puppet-snmp/pull/204) ([blackknight36](https://github.com/blackknight36))
- Updated stdlib to 4.22.0 [\#179](https://github.com/voxpupuli/puppet-snmp/pull/179) ([thaylin](https://github.com/thaylin))
- Rewrite user creation to prevent quoting bug \(fixes \#173\) [\#176](https://github.com/voxpupuli/puppet-snmp/pull/176) ([smoeding](https://github.com/smoeding))

**Closed issues:**

- unit tests are failing [\#199](https://github.com/voxpupuli/puppet-snmp/issues/199)
- Clean up function puppet-strings docs [\#185](https://github.com/voxpupuli/puppet-snmp/issues/185)
- Deprecate razorsedge/snmp [\#163](https://github.com/voxpupuli/puppet-snmp/issues/163)

**Merged pull requests:**

- Remove duplicate CONTRIBUTING.md file [\#209](https://github.com/voxpupuli/puppet-snmp/pull/209) ([dhoppe](https://github.com/dhoppe))
- Install client only when required to avoid potential duplicate resource. [\#203](https://github.com/voxpupuli/puppet-snmp/pull/203) ([pillarsdotnet](https://github.com/pillarsdotnet))
- Allow puppetlabs/stdlib 6.x [\#202](https://github.com/voxpupuli/puppet-snmp/pull/202) ([pillarsdotnet](https://github.com/pillarsdotnet))
- remove BSD from hiera data [\#201](https://github.com/voxpupuli/puppet-snmp/pull/201) ([Dan33l](https://github.com/Dan33l))
- Mark `snmp::snmpv3_usm_hash` as private [\#186](https://github.com/voxpupuli/puppet-snmp/pull/186) ([alexjfisher](https://github.com/alexjfisher))

## [v4.1.0](https://github.com/voxpupuli/puppet-snmp/tree/v4.1.0) (2018-11-23)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/v4.0.0...v4.1.0)

**Implemented enhancements:**

- Implement snmpv3\_user fact and snmp::snmpv3\_usm\_hash function [\#157](https://github.com/voxpupuli/puppet-snmp/pull/157) ([smoeding](https://github.com/smoeding))

**Fixed bugs:**

- fix snmptrapd on ubuntu and debian [\#168](https://github.com/voxpupuli/puppet-snmp/pull/168) ([amateo](https://github.com/amateo))

**Merged pull requests:**

- use puppet strings format for reference [\#167](https://github.com/voxpupuli/puppet-snmp/pull/167) ([Dan33l](https://github.com/Dan33l))
- add acceptance tests with beaker [\#166](https://github.com/voxpupuli/puppet-snmp/pull/166) ([Dan33l](https://github.com/Dan33l))

## [v4.0.0](https://github.com/voxpupuli/puppet-snmp/tree/v4.0.0) (2018-11-08)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.9.0...v4.0.0)

**Breaking changes:**

- Remove the use of global variables [\#145](https://github.com/voxpupuli/puppet-snmp/pull/145) ([ekohl](https://github.com/ekohl))
- Remove `validate_numeric` and `validate_string` [\#144](https://github.com/voxpupuli/puppet-snmp/pull/144) ([alexjfisher](https://github.com/alexjfisher))
- Remove deprecated `install_client` parameter [\#143](https://github.com/voxpupuli/puppet-snmp/pull/143) ([alexjfisher](https://github.com/alexjfisher))
- Migrate stuff to Vox Pupuli; Drop Puppet 2/3 support; require stdlib 4.13.1 or newer [\#135](https://github.com/voxpupuli/puppet-snmp/pull/135) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Debian Stretch \(new stable\) use a different user for snmpd [\#108](https://github.com/voxpupuli/puppet-snmp/issues/108)
- Add $snmpv2\_enable parameter [\#136](https://github.com/voxpupuli/puppet-snmp/pull/136) ([hdep](https://github.com/hdep))
- Add ubuntu 18.04 support [\#130](https://github.com/voxpupuli/puppet-snmp/pull/130) ([cliff-wakefield](https://github.com/cliff-wakefield))

**Fixed bugs:**

- validate\_numeric\(\) and friends are deprecated in stdlib [\#111](https://github.com/voxpupuli/puppet-snmp/issues/111)
- Unknown variable: 'snmp\_agentaddress' error [\#65](https://github.com/voxpupuli/puppet-snmp/issues/65)
- Fix typo in snmp::params: s/extemds/extends/ [\#133](https://github.com/voxpupuli/puppet-snmp/pull/133) ([chundaoc](https://github.com/chundaoc))

**Closed issues:**

- Prepare for release 4.0.0 [\#153](https://github.com/voxpupuli/puppet-snmp/issues/153)
- Needs to be updated to support Ubuntu 18 [\#151](https://github.com/voxpupuli/puppet-snmp/issues/151)
- Release the current version on the forge [\#138](https://github.com/voxpupuli/puppet-snmp/issues/138)
- Test cases are broken [\#132](https://github.com/voxpupuli/puppet-snmp/issues/132)
- cannot disable VACM [\#129](https://github.com/voxpupuli/puppet-snmp/issues/129)
- `extemds` variable typo [\#123](https://github.com/voxpupuli/puppet-snmp/issues/123)

**Merged pull requests:**

- update deprecation notice [\#161](https://github.com/voxpupuli/puppet-snmp/pull/161) ([Dan33l](https://github.com/Dan33l))
- update CONTRIBUTING.md copied from .github/CONTRIBUTING.md [\#160](https://github.com/voxpupuli/puppet-snmp/pull/160) ([Dan33l](https://github.com/Dan33l))
- cleanup about OSes in README [\#159](https://github.com/voxpupuli/puppet-snmp/pull/159) ([Dan33l](https://github.com/Dan33l))
- move copyright notice from manifests to updated Development section in README [\#158](https://github.com/voxpupuli/puppet-snmp/pull/158) ([Dan33l](https://github.com/Dan33l))
- Use rspec-puppet-facts [\#155](https://github.com/voxpupuli/puppet-snmp/pull/155) ([Dan33l](https://github.com/Dan33l))
- use structured facts [\#154](https://github.com/voxpupuli/puppet-snmp/pull/154) ([Dan33l](https://github.com/Dan33l))
- modulesync 2.2.0 and allow puppet 6.x [\#150](https://github.com/voxpupuli/puppet-snmp/pull/150) ([bastelfreak](https://github.com/bastelfreak))
- Various refactoring to improve code readability [\#149](https://github.com/voxpupuli/puppet-snmp/pull/149) ([alexjfisher](https://github.com/alexjfisher))
- Replace validation logic for \*service\_ensure. [\#148](https://github.com/voxpupuli/puppet-snmp/pull/148) ([vStone](https://github.com/vStone))
- Replace validate\_array with proper data types [\#147](https://github.com/voxpupuli/puppet-snmp/pull/147) ([vStone](https://github.com/vStone))
- Replace instances of validate\_re with Enum type [\#146](https://github.com/voxpupuli/puppet-snmp/pull/146) ([alexjfisher](https://github.com/alexjfisher))
- Replace `validate_bool` with `Boolean` data type [\#142](https://github.com/voxpupuli/puppet-snmp/pull/142) ([alexjfisher](https://github.com/alexjfisher))
- Unpin stdlib in fixtures.yml [\#141](https://github.com/voxpupuli/puppet-snmp/pull/141) ([alexjfisher](https://github.com/alexjfisher))
- Include full Apache 2.0 license text and add badge [\#140](https://github.com/voxpupuli/puppet-snmp/pull/140) ([alexjfisher](https://github.com/alexjfisher))

## [3.9.0](https://github.com/voxpupuli/puppet-snmp/tree/3.9.0) (2018-01-07)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.8.1...3.9.0)

**Implemented enhancements:**

- adding possibility to configure extend-slines in snmpd.conf [\#118](https://github.com/voxpupuli/puppet-snmp/pull/118) ([tjungbauer](https://github.com/tjungbauer))
- Added extra logic to handle Debian 9 \(Stretch\) [\#113](https://github.com/voxpupuli/puppet-snmp/pull/113) ([Pavulon007](https://github.com/Pavulon007))

**Fixed bugs:**

- Using an array for ro\_community breaks snmptrapd [\#106](https://github.com/voxpupuli/puppet-snmp/issues/106)

## [3.8.1](https://github.com/voxpupuli/puppet-snmp/tree/3.8.1) (2017-06-15)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.8.0...3.8.1)

**Fixed bugs:**

- Problem with puppet v4 [\#103](https://github.com/voxpupuli/puppet-snmp/issues/103)
- Fix snmptrapd community string configuration [\#107](https://github.com/voxpupuli/puppet-snmp/pull/107) ([djschaap](https://github.com/djschaap))

## [3.8.0](https://github.com/voxpupuli/puppet-snmp/tree/3.8.0) (2017-05-28)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.7.0...3.8.0)

**Implemented enhancements:**

- Add master options to snmpd.conf [\#104](https://github.com/voxpupuli/puppet-snmp/pull/104) ([coreone](https://github.com/coreone))
- Fix strict variables [\#102](https://github.com/voxpupuli/puppet-snmp/pull/102) ([coreone](https://github.com/coreone))

**Fixed bugs:**

- Change - Update requirements for the snmp::client class [\#98](https://github.com/voxpupuli/puppet-snmp/pull/98) ([blackknight36](https://github.com/blackknight36))

**Merged pull requests:**

- Update requirements for the snmp client class [\#105](https://github.com/voxpupuli/puppet-snmp/pull/105) ([blackknight36](https://github.com/blackknight36))

## [3.7.0](https://github.com/voxpupuli/puppet-snmp/tree/3.7.0) (2017-04-23)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.6.0...3.7.0)

**Implemented enhancements:**

- Support service\_config\_dir\_group class parameter [\#93](https://github.com/voxpupuli/puppet-snmp/pull/93) ([adepretis](https://github.com/adepretis))
- Add Dell OpenManage StorageServices smux OID [\#90](https://github.com/voxpupuli/puppet-snmp/pull/90) ([vide](https://github.com/vide))
- Add OpenBSD to the supported operating systems, similar to FreeBSD [\#74](https://github.com/voxpupuli/puppet-snmp/pull/74) ([buzzdeee](https://github.com/buzzdeee))
- Create Parameters for template files. [\#73](https://github.com/voxpupuli/puppet-snmp/pull/73) ([aschaber1](https://github.com/aschaber1))

**Fixed bugs:**

- CI failing, Module sync out of date. [\#75](https://github.com/voxpupuli/puppet-snmp/issues/75)

**Closed issues:**

- File permissions do not match the ones of the net-snmp  [\#81](https://github.com/voxpupuli/puppet-snmp/issues/81)

## [3.6.0](https://github.com/voxpupuli/puppet-snmp/tree/3.6.0) (2015-12-20)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.5.0...3.6.0)

**Implemented enhancements:**

- Multiple rocommunity,rwcommunity [\#57](https://github.com/voxpupuli/puppet-snmp/issues/57)
- Conglomerate of PRs with tests [\#62](https://github.com/voxpupuli/puppet-snmp/pull/62) ([jrwesolo](https://github.com/jrwesolo))

**Fixed bugs:**

- creating snmpv3 users fails with passphrases containing spaces [\#33](https://github.com/voxpupuli/puppet-snmp/issues/33)

## [3.5.0](https://github.com/voxpupuli/puppet-snmp/tree/3.5.0) (2015-10-15)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.4.0...3.5.0)

**Implemented enhancements:**

- Add the ability pass multiple networks for the community string [\#55](https://github.com/voxpupuli/puppet-snmp/pull/55) ([rdrgmnzs](https://github.com/rdrgmnzs))

**Fixed bugs:**

- quote snmpv3 passphrases to cope with weird characters and spaces [\#42](https://github.com/voxpupuli/puppet-snmp/pull/42) ([Seegras](https://github.com/Seegras))

## [3.4.0](https://github.com/voxpupuli/puppet-snmp/tree/3.4.0) (2015-07-07)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.3.1...3.4.0)

**Implemented enhancements:**

- Creating snmpv3 users on loaded system fails [\#46](https://github.com/voxpupuli/puppet-snmp/issues/46)
- snmpd\_options and other /etc/defaults/snmpd options is not in docs [\#30](https://github.com/voxpupuli/puppet-snmp/issues/30)
- rocommunity commented out [\#10](https://github.com/voxpupuli/puppet-snmp/issues/10)

**Fixed bugs:**

- ro\_community cannot be set to 'undef' to remove from ERB template [\#36](https://github.com/voxpupuli/puppet-snmp/issues/36)
- skip zero length strings in ERB template output [\#41](https://github.com/voxpupuli/puppet-snmp/pull/41) ([bdellegrazie](https://github.com/bdellegrazie))

**Closed issues:**

- Not possible to not start snmptrapd service [\#52](https://github.com/voxpupuli/puppet-snmp/issues/52)
- No support for syslocation/syscontact [\#45](https://github.com/voxpupuli/puppet-snmp/issues/45)
- CentOS 7.1 breaks params.rb [\#44](https://github.com/voxpupuli/puppet-snmp/issues/44)

## [3.3.1](https://github.com/voxpupuli/puppet-snmp/tree/3.3.1) (2015-01-03)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.3.0...3.3.1)

## [3.3.0](https://github.com/voxpupuli/puppet-snmp/tree/3.3.0) (2014-12-29)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.2.0...3.3.0)

**Implemented enhancements:**

- `ensure => absent` fails on el5/el6 if net-snmp-utils is installed [\#20](https://github.com/voxpupuli/puppet-snmp/issues/20)
- Add support for Dell's OpenManage [\#28](https://github.com/voxpupuli/puppet-snmp/pull/28) ([erinn](https://github.com/erinn))
- Disable logging from tcpwrappers in snmpd.conf [\#27](https://github.com/voxpupuli/puppet-snmp/pull/27) ([erinn](https://github.com/erinn))
- IPv6 support round 2 [\#26](https://github.com/voxpupuli/puppet-snmp/pull/26) ([erinn](https://github.com/erinn))

## [3.2.0](https://github.com/voxpupuli/puppet-snmp/tree/3.2.0) (2014-10-07)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.1.0...3.2.0)

**Implemented enhancements:**

- dynamic sysname? [\#14](https://github.com/voxpupuli/puppet-snmp/issues/14)

**Fixed bugs:**

- Future parser and puppet-snmp [\#23](https://github.com/voxpupuli/puppet-snmp/issues/23)

**Merged pull requests:**

- Lowercase variable names [\#22](https://github.com/voxpupuli/puppet-snmp/pull/22) ([invliD](https://github.com/invliD))

## [3.1.0](https://github.com/voxpupuli/puppet-snmp/tree/3.1.0) (2014-05-25)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/3.0.0...3.1.0)

**Closed issues:**

- The documentation for init.pp incorrectly suggests that the snmp class takes a 'services' parameter [\#11](https://github.com/voxpupuli/puppet-snmp/issues/11)

## [3.0.0](https://github.com/voxpupuli/puppet-snmp/tree/3.0.0) (2013-07-13)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/2.0.0...3.0.0)

**Implemented enhancements:**

- Trapd extended [\#7](https://github.com/voxpupuli/puppet-snmp/pull/7) ([ghost](https://github.com/ghost))

## [2.0.0](https://github.com/voxpupuli/puppet-snmp/tree/2.0.0) (2013-06-23)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/1.0.1...2.0.0)

**Merged pull requests:**

- modified templates to dereference class parameters [\#2](https://github.com/voxpupuli/puppet-snmp/pull/2) ([hakamadare](https://github.com/hakamadare))

## [1.0.1](https://github.com/voxpupuli/puppet-snmp/tree/1.0.1) (2012-05-26)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/1.0.0...1.0.1)

## [1.0.0](https://github.com/voxpupuli/puppet-snmp/tree/1.0.0) (2012-05-07)

[Full Changelog](https://github.com/voxpupuli/puppet-snmp/compare/d4a4953f4c20ceef5c9b538645e602e498663aec...1.0.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
