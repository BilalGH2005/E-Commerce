import 'package:flutter/material.dart';

enum AsyncStatus { loading, data, error }

class AsyncValue<T> {
  final AsyncStatus status;
  T? data;
  Object? error;

  AsyncValue.loading() : status = AsyncStatus.loading;

  AsyncValue.data({required this.data}) : status = AsyncStatus.data;

  AsyncValue.error({required this.error}) : status = AsyncStatus.error;
}

class AsyncBuilder<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(BuildContext context) loading;
  final Widget Function(BuildContext context, T data) data;
  final Widget Function(BuildContext context, Object error) error;

  const AsyncBuilder({
    super.key,
    required this.value,
    required this.loading,
    required this.data,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (value.status == AsyncStatus.loading) {
      return loading(context);
    }
    if (value.status == AsyncStatus.data) {
      return data(context, value.data as T);
    }
    return error(context, value.error!);
  }
}
