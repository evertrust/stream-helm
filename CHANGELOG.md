# Changelog

## [2.0.0](https://github.com/evertrust/stream-helm/compare/v1.6.7...v2.0.0) (2025-02-24)


### ⚠ BREAKING CHANGES

* Graduate to v1.0.0

### Features

* **0.1.2:** Bumped Stream version to 1.1.1 ([b3287f1](https://github.com/evertrust/stream-helm/commit/b3287f14b05bd9426edbdb7983234744d0b3c99c))
* **0.1.4:** Ability to define global image overrides ([20f6b75](https://github.com/evertrust/stream-helm/commit/20f6b75b62076a0d8dc51c5cf3640aece2de41a7))
* **0.1.4:** STM-117: TLS between Stream & the reverse proxy ([3c3de95](https://github.com/evertrust/stream-helm/commit/3c3de95c10c41ff3943db82d4a0435deac95777b))
* **0.1.4:** STM-119: Support structured logging ([8f8a251](https://github.com/evertrust/stream-helm/commit/8f8a251ee3bef499ca60f1581aedbb32940b3b4a))
* **0.1.4:** Use the Kubernetes API instead of an headless DNS service ([29378a0](https://github.com/evertrust/stream-helm/commit/29378a012b9deb5ade65d402aa13d3277e7d5e0d))
* **0.1.6:** Allow initContainers ([10b10cb](https://github.com/evertrust/stream-helm/commit/10b10cbbfcfb019d845b66abfb35dc8e10c6e74f))
* **0.1.6:** Use podsDirectConnect for GKE Autopilot clusters ([3368e12](https://github.com/evertrust/stream-helm/commit/3368e12871b472c6dec722c601974e27c5351989))
* **backup:** add backup support ([#31](https://github.com/evertrust/stream-helm/issues/31)) ([d2012a0](https://github.com/evertrust/stream-helm/commit/d2012a00e0fcd7d41f3c3dab4ca483f5e2580b3c))
* **extraObjects:** support creation of extra manifests via values ([#4](https://github.com/evertrust/stream-helm/issues/4)) ([cefff69](https://github.com/evertrust/stream-helm/commit/cefff697d2db6410399279f6088f9c224a82f6aa))
* Graduate to v1.0.0 ([3ea6855](https://github.com/evertrust/stream-helm/commit/3ea6855946eb654ba1fd850e21c5658ec540db06))
* **intialAdminHashPassword:** support ([#23](https://github.com/evertrust/stream-helm/issues/23)) ([df8b551](https://github.com/evertrust/stream-helm/commit/df8b551d2c64e1c0c143b4eb4f5e6e1096d94ea4))
* **mailer:** allow smtp config ([#19](https://github.com/evertrust/stream-helm/issues/19)) ([816cb13](https://github.com/evertrust/stream-helm/commit/816cb13a7cec53e80096c6f773948e84d57a0e3f))
* **metrics:** support metrics configuration ([#27](https://github.com/evertrust/stream-helm/issues/27)) ([066db31](https://github.com/evertrust/stream-helm/commit/066db318af43aec377e04c6082c7cc154964eb47))
* **upgrade:** support force option ([#21](https://github.com/evertrust/stream-helm/issues/21)) ([5fa8456](https://github.com/evertrust/stream-helm/commit/5fa8456e31ea511ce2b2df92bdd0bc0aebe90815))


### Bug Fixes

* allow clustering multiple instances of Stream in the same namespace ([3d816f1](https://github.com/evertrust/stream-helm/commit/3d816f1687bcf783f610d1de9e4e16315198a1b5))
* backup command ([5e310af](https://github.com/evertrust/stream-helm/commit/5e310af5e936b562180c9bb1f89c31b055deb8b5))
* bump stream to 2.0.2 ([#7](https://github.com/evertrust/stream-helm/issues/7)) ([ab2b554](https://github.com/evertrust/stream-helm/commit/ab2b5549241aec3c7e605394823d82ba5da5f283))
* bump stream to 2.0.3 ([#9](https://github.com/evertrust/stream-helm/issues/9)) ([4750faa](https://github.com/evertrust/stream-helm/commit/4750faa759b08b383d7796faad8db76f484594ba))
* bump stream to 2.0.4 ([#11](https://github.com/evertrust/stream-helm/issues/11)) ([4e4c6ce](https://github.com/evertrust/stream-helm/commit/4e4c6ce10e802c623a9db1e8126487670c01e09b))
* bump stream to 2.0.5 ([#13](https://github.com/evertrust/stream-helm/issues/13)) ([c69ba60](https://github.com/evertrust/stream-helm/commit/c69ba608875fed79e9418a214a03def3df77c250))
* bump stream to 2.0.6 ([#15](https://github.com/evertrust/stream-helm/issues/15)) ([7737ec7](https://github.com/evertrust/stream-helm/commit/7737ec7985f5dc06154637449bd6e83905964b52))
* bump stream to 2.0.7 ([#29](https://github.com/evertrust/stream-helm/issues/29)) ([1a61c53](https://github.com/evertrust/stream-helm/commit/1a61c5393933fd8438824dd4726d84708fd36649))
* bump stream to 2.0.8 ([#42](https://github.com/evertrust/stream-helm/issues/42)) ([52c60d3](https://github.com/evertrust/stream-helm/commit/52c60d3d75964a58c89057f6c4a485ea025e7d9e))
* bump to 2.0.9 ([#52](https://github.com/evertrust/stream-helm/issues/52)) ([b8c73d8](https://github.com/evertrust/stream-helm/commit/b8c73d87b7570d36ce2b924d397432f8f21fedb2))
* bump toolbox version ([1bf9c91](https://github.com/evertrust/stream-helm/commit/1bf9c91792aafcf9396e0118ca6eae0b914f714b))
* cronJob name lenght ([#36](https://github.com/evertrust/stream-helm/issues/36)) ([dfd51fc](https://github.com/evertrust/stream-helm/commit/dfd51fccffb72e8e0a2c283bb5ddfaec6be84466))
* Fixed application version ([2b9fff5](https://github.com/evertrust/stream-helm/commit/2b9fff5c263627fdfb8f2efe539bc67790fd4811))
* Removed duplicate environment variable ([ec23400](https://github.com/evertrust/stream-helm/commit/ec23400bd808256fe8054f74170aac8411e3c48b))
* security context rollback ([#38](https://github.com/evertrust/stream-helm/issues/38)) ([0c70c01](https://github.com/evertrust/stream-helm/commit/0c70c0188f3f142bf00674d67ada58b040d77754))
* set resource limit/request and security context for upgrade/back… ([#34](https://github.com/evertrust/stream-helm/issues/34)) ([14dd889](https://github.com/evertrust/stream-helm/commit/14dd889adfbf840871894c7514a0b9504bf09863))
* Stream Akka configuration template HA ([#25](https://github.com/evertrust/stream-helm/issues/25)) ([50f1e94](https://github.com/evertrust/stream-helm/commit/50f1e94bac3bcf9617282b9dd7eef449b4d8cf65))
* toolbox bump to 0.3.0 ([#40](https://github.com/evertrust/stream-helm/issues/40)) ([3c0bdd0](https://github.com/evertrust/stream-helm/commit/3c0bdd047b4848431780f892085dd3fbaaf5fc15))
* update job template ([7eaee42](https://github.com/evertrust/stream-helm/commit/7eaee42f225f53e9658d82f3ac0740d9a3bf1d3d))
* upgrade job - pullSecrets indentation ([#17](https://github.com/evertrust/stream-helm/issues/17)) ([18079bc](https://github.com/evertrust/stream-helm/commit/18079bcf8fd2b36672a88b1a7987f2b3a0e0a8bb))
* upgrade pod pullSecrets indentation ([149bd72](https://github.com/evertrust/stream-helm/commit/149bd721b4a1b9dcd42bbf88ed7dc0089ad26e5c))

## [1.6.6](https://github.com/evertrust/stream-helm/compare/v1.6.5...v1.6.6) (2025-01-14)


### Bug Fixes

* bump stream to 2.0.8 ([#42](https://github.com/evertrust/stream-helm/issues/42)) ([52c60d3](https://github.com/evertrust/stream-helm/commit/52c60d3d75964a58c89057f6c4a485ea025e7d9e))

## [1.6.5](https://github.com/evertrust/stream-helm/compare/v1.6.4...v1.6.5) (2024-12-13)


### Bug Fixes

* toolbox bump to 0.3.0 ([#40](https://github.com/evertrust/stream-helm/issues/40)) ([3c0bdd0](https://github.com/evertrust/stream-helm/commit/3c0bdd047b4848431780f892085dd3fbaaf5fc15))

## [1.6.4](https://github.com/evertrust/stream-helm/compare/v1.6.3...v1.6.4) (2024-12-10)


### Bug Fixes

* security context rollback ([#38](https://github.com/evertrust/stream-helm/issues/38)) ([0c70c01](https://github.com/evertrust/stream-helm/commit/0c70c0188f3f142bf00674d67ada58b040d77754))

## [1.6.3](https://github.com/evertrust/stream-helm/compare/v1.6.2...v1.6.3) (2024-12-09)


### Bug Fixes

* cronJob name lenght ([#36](https://github.com/evertrust/stream-helm/issues/36)) ([dfd51fc](https://github.com/evertrust/stream-helm/commit/dfd51fccffb72e8e0a2c283bb5ddfaec6be84466))

## [1.6.2](https://github.com/evertrust/stream-helm/compare/v1.6.1...v1.6.2) (2024-12-09)


### Bug Fixes

* set resource limit/request and security context for upgrade/back… ([#34](https://github.com/evertrust/stream-helm/issues/34)) ([14dd889](https://github.com/evertrust/stream-helm/commit/14dd889adfbf840871894c7514a0b9504bf09863))

## [1.6.1](https://github.com/evertrust/stream-helm/compare/v1.6.0...v1.6.1) (2024-12-06)


### Bug Fixes

* backup command ([5e310af](https://github.com/evertrust/stream-helm/commit/5e310af5e936b562180c9bb1f89c31b055deb8b5))

## [1.6.0](https://github.com/evertrust/stream-helm/compare/v1.5.1...v1.6.0) (2024-12-06)


### Features

* **backup:** add backup support ([#31](https://github.com/evertrust/stream-helm/issues/31)) ([d2012a0](https://github.com/evertrust/stream-helm/commit/d2012a00e0fcd7d41f3c3dab4ca483f5e2580b3c))


### Bug Fixes

* bump toolbox version ([1bf9c91](https://github.com/evertrust/stream-helm/commit/1bf9c91792aafcf9396e0118ca6eae0b914f714b))
* update job template ([7eaee42](https://github.com/evertrust/stream-helm/commit/7eaee42f225f53e9658d82f3ac0740d9a3bf1d3d))

## [1.5.1](https://github.com/evertrust/stream-helm/compare/v1.5.0...v1.5.1) (2024-11-29)


### Bug Fixes

* bump stream to 2.0.7 ([#29](https://github.com/evertrust/stream-helm/issues/29)) ([1a61c53](https://github.com/evertrust/stream-helm/commit/1a61c5393933fd8438824dd4726d84708fd36649))

## [1.5.0](https://github.com/evertrust/stream-helm/compare/v1.4.1...v1.5.0) (2024-11-21)


### Features

* **metrics:** support metrics configuration ([#27](https://github.com/evertrust/stream-helm/issues/27)) ([066db31](https://github.com/evertrust/stream-helm/commit/066db318af43aec377e04c6082c7cc154964eb47))

## [1.4.1](https://github.com/evertrust/stream-helm/compare/v1.4.0...v1.4.1) (2024-10-31)


### Bug Fixes

* Stream Akka configuration template HA ([#25](https://github.com/evertrust/stream-helm/issues/25)) ([50f1e94](https://github.com/evertrust/stream-helm/commit/50f1e94bac3bcf9617282b9dd7eef449b4d8cf65))

## [1.4.0](https://github.com/evertrust/stream-helm/compare/v1.3.0...v1.4.0) (2024-10-17)


### Features

* **intialAdminHashPassword:** support ([#23](https://github.com/evertrust/stream-helm/issues/23)) ([df8b551](https://github.com/evertrust/stream-helm/commit/df8b551d2c64e1c0c143b4eb4f5e6e1096d94ea4))

## [1.3.0](https://github.com/evertrust/stream-helm/compare/v1.2.0...v1.3.0) (2024-10-01)


### Features

* **upgrade:** support force option ([#21](https://github.com/evertrust/stream-helm/issues/21)) ([5fa8456](https://github.com/evertrust/stream-helm/commit/5fa8456e31ea511ce2b2df92bdd0bc0aebe90815))

## [1.2.0](https://github.com/evertrust/stream-helm/compare/v1.1.6...v1.2.0) (2024-09-26)


### Features

* **mailer:** allow smtp config ([#19](https://github.com/evertrust/stream-helm/issues/19)) ([816cb13](https://github.com/evertrust/stream-helm/commit/816cb13a7cec53e80096c6f773948e84d57a0e3f))

## [1.1.6](https://github.com/evertrust/stream-helm/compare/v1.1.5...v1.1.6) (2024-09-13)


### Bug Fixes

* upgrade job - pullSecrets indentation ([#17](https://github.com/evertrust/stream-helm/issues/17)) ([18079bc](https://github.com/evertrust/stream-helm/commit/18079bcf8fd2b36672a88b1a7987f2b3a0e0a8bb))

## [1.1.5](https://github.com/evertrust/stream-helm/compare/v1.1.4...v1.1.5) (2024-09-06)


### Bug Fixes

* bump stream to 2.0.6 ([#15](https://github.com/evertrust/stream-helm/issues/15)) ([7737ec7](https://github.com/evertrust/stream-helm/commit/7737ec7985f5dc06154637449bd6e83905964b52))

## [1.1.4](https://github.com/evertrust/stream-helm/compare/v1.1.3...v1.1.4) (2024-08-28)


### Bug Fixes

* bump stream to 2.0.5 ([#13](https://github.com/evertrust/stream-helm/issues/13)) ([c69ba60](https://github.com/evertrust/stream-helm/commit/c69ba608875fed79e9418a214a03def3df77c250))

## [1.1.3](https://github.com/evertrust/stream-helm/compare/v1.1.2...v1.1.3) (2024-08-28)


### Bug Fixes

* bump stream to 2.0.4 ([#11](https://github.com/evertrust/stream-helm/issues/11)) ([4e4c6ce](https://github.com/evertrust/stream-helm/commit/4e4c6ce10e802c623a9db1e8126487670c01e09b))

## [1.1.2](https://github.com/evertrust/stream-helm/compare/v1.1.1...v1.1.2) (2024-08-28)


### Bug Fixes

* bump stream to 2.0.3 ([#9](https://github.com/evertrust/stream-helm/issues/9)) ([4750faa](https://github.com/evertrust/stream-helm/commit/4750faa759b08b383d7796faad8db76f484594ba))

## [1.1.1](https://github.com/evertrust/stream-helm/compare/v1.1.0...v1.1.1) (2024-08-23)


### Bug Fixes

* bump stream to 2.0.2 ([#7](https://github.com/evertrust/stream-helm/issues/7)) ([ab2b554](https://github.com/evertrust/stream-helm/commit/ab2b5549241aec3c7e605394823d82ba5da5f283))

## [1.1.0](https://github.com/evertrust/stream-helm/compare/v1.0.2...v1.1.0) (2024-08-19)


### Features

* **extraObjects:** support creation of extra manifests via values ([#4](https://github.com/evertrust/stream-helm/issues/4)) ([cefff69](https://github.com/evertrust/stream-helm/commit/cefff697d2db6410399279f6088f9c224a82f6aa))

## [1.0.2](https://github.com/evertrust/stream-helm/compare/v1.0.1...v1.0.2) (2024-08-16)


### Bug Fixes

* upgrade pod pullSecrets indentation ([149bd72](https://github.com/evertrust/stream-helm/commit/149bd721b4a1b9dcd42bbf88ed7dc0089ad26e5c))

## [1.0.1](https://github.com/evertrust/stream-helm/compare/v1.0.0...v1.0.1) (2024-08-06)


### Bug Fixes

* Fixed application version ([2b9fff5](https://github.com/evertrust/stream-helm/commit/2b9fff5c263627fdfb8f2efe539bc67790fd4811))
* Removed duplicate environment variable ([ec23400](https://github.com/evertrust/stream-helm/commit/ec23400bd808256fe8054f74170aac8411e3c48b))

## [1.0.0](https://github.com/evertrust/stream-helm/compare/v0.2.2...v1.0.0) (2024-08-02)


### ⚠ BREAKING CHANGES

* Graduate to v1.0.0

### Features

* Graduate to v1.0.0 ([3ea6855](https://github.com/evertrust/stream-helm/commit/3ea6855946eb654ba1fd850e21c5658ec540db06))

## [0.2.2](https://github.com/evertrust/stream-helm/compare/0.2.1...v0.2.2) (2024-07-19)


### Bug Fixes

* allow clustering multiple instances of Stream in the same namespace ([3d816f1](https://github.com/evertrust/stream-helm/commit/3d816f1687bcf783f610d1de9e4e16315198a1b5))
