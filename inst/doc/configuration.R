## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", eval = FALSE, error = FALSE)

## -----------------------------------------------------------------------------
# spec <- platypus_spec("run.yaml")
# fit <- platypus_fit(spec)
# evaluate(fit)

## -----------------------------------------------------------------------------
# fit <- platypus_fit(platypus_spec("run.yaml"))
# evaluate(fit)            # one row per model
# training_history(fit)    # one row per model per epoch

## -----------------------------------------------------------------------------
# segmentation_data("data/all", split = list(fractions = c(0.8, 0.2), group_by = NULL))
# segmentation_data("data/train", validation = "data/validation")
# segmentation_data("data/all", validation = FALSE)

## -----------------------------------------------------------------------------
# u_net(
#   "augmented",
#   input_shape = c(256, 256),
#   epochs = 40,
#   loss = loss_dice(),
#   metrics = list(metric_iou(), metric_dice()),
#   optimizer = optimizer_adam(learning_rate = 0.001),
#   callbacks = list(
#     callback_early_stopping(monitor = "val_loss", patience = 10),
#     callback_model_checkpoint(monitor = "val_iou", path = "runs/best.safetensors")
#   ),
#   augmentation = list(
#     augmentation_step("HorizontalFlip", p = 0.5),
#     augmentation_step("RandomBrightnessContrast", p = 0.3)
#   )
# )

## -----------------------------------------------------------------------------
# spec <- platypus_spec(
#   data = segmentation_data(
#     "data/train", "data/validation",
#     regions = list(
#       list(name = "whole tumour", of = c(1, 2, 4)),
#       list(name = "tumour core", of = c(1, 4)),
#       list(name = "enhancing", of = 4)
#     )
#   ),
#   models = list(u_net("brats", input_shape = c(240, 240), loss = loss_focal()))
# )

## -----------------------------------------------------------------------------
# inspect_masks(spec)
# #>   split unmatched samples_checked total_samples present_classes      missing_classes
# #> 1 train    0.0000             500          1251 whole tumour, ...    enhancing

## -----------------------------------------------------------------------------
# spec <- platypus_spec(
#   data = segmentation_data(
#     "data/train", "data/validation",
#     classes_from = c("_vessel\\.png$", "_organ\\.png$")
#   ),
#   models = list(u_net("crossing", input_shape = c(256, 256)))
# )

## -----------------------------------------------------------------------------
# spec <- platypus_spec(
#   data = instance_data("data/train", "data/validation"),
#   models = list(
#     u_net(
#       "rim",
#       input_shape = c(256, 256),
#       separation = separation_rim(width = 2),
#       loss = loss_cce_dice(),
#       decode = list(decode_nearest_seed(), decode_connected_components())
#     ),
#     u_net(
#       "flows",
#       input_shape = c(256, 256),
#       separation = separation_flows(loss = loss_mse(where = "foreground"))
#     )
#   )
# )
# fit <- platypus_fit(spec)
# evaluate(fit)

## -----------------------------------------------------------------------------
# spec <- platypus_spec(
#   data = classification_data("data/train", "data/validation",
#                              classes = c("benign", "malignant")),
#   models = list(
#     classifier("ours", input_shape = c(128, 128), blocks = 4, filters = 16,
#                loss = loss_cce(),
#                metrics = list(metric_auc(), metric_balanced_accuracy())),
#     classifier("resnet", input_shape = c(224, 224), encoder = "resnet34",
#                pretrained = TRUE, freeze_encoder = 2, pooling = "max",
#                head_dropout = 0.2, loss = loss_focal(gamma = 2))
#   )
# )

## -----------------------------------------------------------------------------
# spec <- platypus_spec(
#   data = classification_data(
#     "data/train.csv", "data/validation.csv",
#     classes = c("atelectasis", "effusion", "nodule", "mass"),
#     labels_from = c("Atelectasis", "Effusion", "Nodule", "Mass"),
#     mode = "config_file"
#   ),
#   models = list(
#     classifier("ours", input_shape = c(224, 224), blocks = 4, filters = 16,
#                loss = loss_cce(), metrics = list(metric_auc(), metric_f1()))
#   )
# )

## -----------------------------------------------------------------------------
# spec <- platypus_spec("run.yaml")
# 
# spec <- platypus_spec(
#   data = segmentation_data(
#     "data/train",
#     validation = "data/validation",
#     colormap = list(c(0, 0, 0), c(255, 255, 255))
#   ),
#   models = list(u_net("first_try", input_shape = c(256, 256)))
# )

## -----------------------------------------------------------------------------
# yaml::write_yaml(as.list(spec), "run.yaml")

