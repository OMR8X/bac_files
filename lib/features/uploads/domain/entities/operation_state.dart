enum OperationState {
  ///
  /// file is [initializing]
  initializing,

  ///
  /// file still [pending] for upload
  pending,

  ///
  /// File is currently [uploading]
  uploading,

  ///
  /// File has [failed] to upload
  failed,
  ///
  /// File has [canceled]
  canceled,

  ///
  /// File has been uploaded [successfully]
  succeed,
}
