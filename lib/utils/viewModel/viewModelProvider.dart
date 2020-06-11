import 'package:flutter/widgets.dart';
import 'package:reference_photo_app/utils/viewModel/viewModel.dart';

class ViewModelProvider<TViewModel extends ViewModel> extends InheritedWidget {
  final TViewModel viewModel;
  ViewModelProvider(
      {Key key,
      @required TViewModel viewModel,
      @required WidgetBuilder childBuilder})
      : this._default(
            key: key, viewModel: viewModel, childBuilder: childBuilder);

  ViewModelProvider._default(
      {Key key,
      @required TViewModel viewModel,
      @required WidgetBuilder childBuilder})
      : assert(viewModel != null),
        assert(childBuilder != null),
        viewModel = viewModel,
        super(
            key: key,
            child: ViewModelViewStateManager(
              viewModel: viewModel,
              childBuilder: childBuilder,
            ));

  @override
  bool updateShouldNotify(ViewModelProvider<TViewModel> oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}

class ViewModelViewStateManager extends StatefulWidget {
  final ViewModel _viewModel;
  final WidgetBuilder _childBuilder;
  ViewModelViewStateManager(
      {@required ViewModel viewModel, @required WidgetBuilder childBuilder})
      : assert(viewModel != null),
        assert(childBuilder != null),
        _childBuilder = childBuilder,
        _viewModel = viewModel;

  @override
  State<StatefulWidget> createState() => _ViewModelViewStateManagerState();
}

class _ViewModelViewStateManagerState extends State<ViewModelViewStateManager> {
  @override
  void initState() {
    super.initState();
    widget._viewModel.viewInitState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget._childBuilder(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    widget._viewModel.viewDispose();
    super.dispose();
  }
}
