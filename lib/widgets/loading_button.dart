import 'dart:developer';

import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Future Function()? onpressed;
  final String text;
  const LoadingButton({Key? key, this.onpressed, required this.text,})
      : super(key: key);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      width: 150,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.amber.shade700, primary: Colors.amber),
          onPressed:
              (_isloading || widget.onpressed == null) ? null : _loadfuture,
          child: _isloading
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                    backgroundColor: Colors.green,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
    );
  }
  Future<void> _loadfuture() async {
    setState(() {
      _isloading = true;
    });
    try {
      await widget.onpressed!();
    } catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }
}

